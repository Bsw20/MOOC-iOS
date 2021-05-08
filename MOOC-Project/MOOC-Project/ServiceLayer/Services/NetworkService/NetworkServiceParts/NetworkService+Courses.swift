//
//  NetworkService+Courses.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 03.05.2021.
//

import Foundation

extension NetworkService {
    
    func getActualCategories(resultHandler: @escaping ([CourseResponseCategoryDataModel]?, NetworkError?) -> Void) {
        
        let categoriesConfigue = RequestFactory.CategoriesRequests.newCategoriesConfigue()
        let headers = ["content-type": "application/json"]
        
        RootAssembly.coreAssembly.categoriesRequestSender.send(
            with: headers,
            with: nil,
            config: categoriesConfigue) { (result: Result<[CourseResponseCategoryDataModel], NetworkError>) in
            switch result {
            case .success(let response):
                Logger.logNetWork(description: "categories received successfully", logType: .success)
                resultHandler(response, nil)
            case .failure(let error):
                Logger.logNetWork(description: "can't receive categories", logType: .error)
                resultHandler(nil, error)
            }
        }
    }

    func getCourse(id: String, resultHandler: @escaping (Result<GeneralParsedCourseDataModel?, NetworkError>) -> Void) {
        let courseRequestConfigue = RequestFactory.CoursesRequests.newCourseConfigue()
        
        RootAssembly.coreAssembly.courseRequestSender.send(
            with: ["content-type": "application/json",
                   "Authorization": "Bearer \(RootAssembly.serviceAssembly.jwtTokenHandler.getToken(tokenType: .accessToken) ?? "NONE")"],
            with: ["id": id],
            config: courseRequestConfigue) { (result: Result<GeneralCourseResponse, NetworkError>) in
            
            switch result {
            
            case .success(let response):
                resultHandler(.success(self.parseCourse(from: response)))
                
            case .failure(let error):
                switch error {
                case .badCode(let code):
                    if code == 401 {
                        self.refreshToken(resultHandler: {
                            self.getCourse(id: id, resultHandler: resultHandler)
                        })
                    } else {
                        resultHandler(.failure(error))
                    }
                default:
                    resultHandler(.failure(error))
                }
            }
        }
    }
    
    func parseCourse(from response: GeneralCourseResponse) -> GeneralParsedCourseDataModel? {
        guard
            let isViewed = response.isViewed,
            let isLiked = response.isFavourite
            else {
            return nil
        }
        
        guard
            let course = response.course,
            let courseName = course.courseName,
            let id = course.id,
            let shortDescription = course.shortDescription,
            let link = course.link,
            let previewImageLink = course.previewImageLink,
            let duration = course.duration else {return nil}
        
        var categories: [CourseParsedCategoryDataModel] = []
        
        for category in course.categories {
            guard
                let id = category.id,
                let ruName = category.name.ru,
                let enName = category.name.en else {continue}
            categories.append(.init(id: id,
                                    name: .init(ru: ruName, en: enName)))
        }
        
        guard let exAverageScore = course.rating.external.averageScore,
              let exCountReviews = course.rating.external.countReviews,
              let inAverageScore = course.rating.inner.averageScore,
              let inCountReviews = course.rating.inner.countReviews else {return nil}
        
        guard let vId = course.vendor.id,
              let vIcon = course.vendor.icon,
              let vLink = course.vendor.link,
              let vName = course.vendor.name else {return nil}
        
        guard let aIcon = course.author.icon,
              let aName = course.author.name,
              let aLink = course.author.link else {return nil}
        
        guard let priceAmount = course.price.amount,
              let priceCurrency = course.price.currency else {return nil}
        
        guard let countViews = course.countViews,
              let decription = course.description else {return nil}
        
        return
            .init(isFavourite: isLiked,
                  isViewed: isViewed,
                  course: .init(courseLanguages: course.courseLanguages,
                                id: id,
                                courseName: courseName,
                                description: decription,
                                shortDescription: shortDescription,
                                categories: categories,
                                link: link,
                                previewImageLink: previewImageLink,
                                rating: .init(external: .init(averageScore: exAverageScore,
                                                              countReviews: exCountReviews),
                                              inner: .init(averageScore: inAverageScore,
                                                           countReviews: inCountReviews)),
                                countViews: countViews,
                                vendor: .init(id: vId,
                                              name: vName,
                                              link: vLink,
                                              icon: vIcon),
                                author: .init(name: aName,
                                              link: aLink,
                                              icon: aIcon),
                                duration: duration,
                                price: .init(amount: priceAmount,
                                             currency: priceCurrency)))
    }

    func getCourses(arguments: [String: String],
                    resultHandler: @escaping (GeneralParsedCoursesDataModel?, NetworkError?) -> Void) {
        
        let courseRequestConfigue = RequestFactory.CoursesRequests.newCoursesConfigue()
        
        RootAssembly.coreAssembly.coursesRequestSender.send(
            with: ["content-type": "application/json"],
            with: arguments,
            config: courseRequestConfigue) {  (result: Result<CoursesResponse, NetworkError>) in
            switch result {
            case .success(let response):
                resultHandler(self.parseCourses(from: response), nil)
            case .failure(let error):
                resultHandler(nil, error)
            }
        }
    }
    
    func getMainInfo(resultHandler: @escaping (Result<MainInfoParsedDataModel, NetworkError>) -> Void) {
        let getMainConfigue = RequestFactory.CoursesRequests.mainInfoConfigue()
        RootAssembly.coreAssembly.mainInfoRequestSender.send(
            with: ["content-type": "application/json"],
            with: nil,
            config: getMainConfigue) { result in
            switch result {
            case .success(let response):
                if let mainInfo = self.parseMainInfo(from: response) {
                    resultHandler(.success(mainInfo))
                } else {
                    resultHandler(.failure(.badDataWhileParsing(message: "getMainInfo")))
                }
            case .failure(let error):
                resultHandler(.failure(error))
            }
        }
    }
    
    func parseMainInfo(from response: MainInfoResponse) -> MainInfoParsedDataModel? {
        
        guard let compilations = response.compilations,
              let courses = response.courses else {return nil}
        
        var compilationsParsed: [CompilationParsedDataModel] = []
        let coursesParsed: [CourseParsedShortDataModel] = parseCoursesArray(from: courses)
        
        for compilation in compilations {
            guard let name = compilation.name,
                  let ru = name.ru,
                  let en = name.en,
                  let icon = compilation.icon,
                  let link = compilation.link else {continue}
            compilationsParsed.append(.init(name: .init(ru: ru, en: en), icon: icon, link: link))
        }
        return MainInfoParsedDataModel(compilations: compilationsParsed,
                                       courses: coursesParsed)
    }
 
    func parseCoursesArray(from array: [CourseResponseShortDataModel]?) ->
    [CourseParsedShortDataModel]{
        
        guard let array = array else {
            return []
        }
        var models: [CourseParsedShortDataModel] = []
        
        for course in array {
            guard
                let courseName = course.courseName,
                let id = course.id,
                let shortDescription = course.shortDescription,
                let link = course.link,
                let previewImageLink = course.previewImageLink,
                let duration = course.duration else {continue}
            
            var categories: [CourseParsedCategoryDataModel] = []
            
            for category in course.categories {
                guard
                    let id = category.id,
                    let ruName = category.name.ru,
                    let enName = category.name.en else {continue}
                categories.append(.init(id: id,
                                        name: .init(ru: ruName, en: enName)))
            }
            
            guard let exAverageScore = course.rating.external.averageScore,
                  let exCountReviews = course.rating.external.countReviews,
                  let inAverageScore = course.rating.inner.averageScore,
                  let inCountReviews = course.rating.inner.countReviews else {continue}
            
            guard let vId = course.vendor.id,
                  let vIcon = course.vendor.icon,
                  let vLink = course.vendor.link,
                  let vName = course.vendor.name else {continue}
            
            guard let aIcon = course.author.icon,
                  let aName = course.author.name,
                  let aLink = course.author.link else {continue}
            
            guard let priceAmount = course.price.amount,
                  let priceCurrency = course.price.currency else {continue}
            
            models.append(.init(courseLanguages: course.courseLanguages,
                                courseName: courseName,
                                id: id,
                                shortDescription: shortDescription,
                                categories: categories,
                                link: link,
                                previewImageLink: previewImageLink,
                                rating: .init(external: .init(averageScore: exAverageScore,
                                                              countReviews: exCountReviews),
                                              inner: .init(averageScore: inAverageScore,
                                                           countReviews: inCountReviews)),
                                vendor: .init(id: vId,
                                              name: vName,
                                              link: vLink,
                                              icon: vIcon),
                                author: .init(name: aName,
                                              link: aLink,
                                              icon: aIcon),
                                duration: duration,
                                price: .init(amount: priceAmount,
                                             currency: priceCurrency)))
        }
        return models
    }
    
    func parseCourses(from response: CoursesResponse?) -> GeneralParsedCoursesDataModel? {
        guard let response = response else {
            return nil
        }
        
        
        return .init(previousPage: response.previousPage,
                     nextPage: response.nextPage,
                     courses: parseCoursesArray(from: response.courses),
                     countPages: response.countPages ?? 0)
    }

}
