//
//  SearchModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

class SearchModel {
    
    public var categories: [TouchableChip]?
    
    func receiveCategories(result: @escaping([TouchableChip]) -> Void) {
        if let categories = categories {
            result(categories)
        } else {
            RootAssembly.serviceAssembly.networkService.getActualCategories { response, _ in
                guard let response = response else {
                    result([])
                    return
                }
                var categories: [TouchableChip] = []
                for category in response {
                    guard
                        let id = category.id,
                        let ruName = category.name.ru else {continue}
                    categories.append(.init(id: id, name: ruName, isTapped: false))
                }
                self.categories = categories
            }
        }
    }
    
    func parseCourses(from response: CoursesResponse?) -> [CourseParsedShortDataModel] {
        guard let response = response else {
            return []
        }
        var models: [CourseParsedShortDataModel] = []
        
        for course in response.courses {
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
    
    func parseCourse(from response: GeneralCourseResponse) -> GeneralParsedCourseDataModel? {
        guard
            let isViewed = response.isViewed,
            let isLiked = response.isFavourite
            else {
            return nil
        }
        
        
        guard
            let course =  response.course,
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
    
    func searchRequest(
        with stringQuery: String,
        categories: [Int],
        pageNumber: Int,
        pageSize: Int,
        resultHandler: @escaping(CoursesResponse?) -> Void) {
        
        RootAssembly.serviceAssembly.networkService.getCourses(
            arguments: ["pageSize": String(pageSize),
                        "pageNumber": String(pageNumber),
                        "searchQuery": stringQuery,
                        "categories": getCategories(categories: categories)]) { response, _ in
            
            guard let response = response else {
                resultHandler(nil)
                return
            }
            resultHandler(response)
        }
    }
    
    private func getCategories(categories: [Int]) -> String {
        let sortedCategories = categories.sorted()
        return sortedCategories.compactMap({ "\($0)"}).joined(separator: ",")
    }
}
