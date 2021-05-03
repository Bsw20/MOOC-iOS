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

    func getCourse(id: String, resultHandler: @escaping (Result<GeneralCourseResponse, NetworkError>) -> Void) {
        let courseRequestConfigue = RequestFactory.CoursesRequests.newCourseConfigue()
        
        RootAssembly.coreAssembly.courseRequestSender.send(
            with: ["content-type": "application/json",
                   "Authorization": "Bearer \(RootAssembly.serviceAssembly.jwtTokenHandler.getToken(tokenType: .accessToken) ?? "NONE")"],
            with: ["id": id],
            config: courseRequestConfigue) { (result: Result<GeneralCourseResponse, NetworkError>) in
            
            switch result {
            
            case .success(let response):
                resultHandler(.success(response))
                
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
    
    func getCourses(arguments: [String: String],
                    resultHandler: @escaping (CoursesResponse?, NetworkError?) -> Void) {
        
        let courseRequestConfigue = RequestFactory.CoursesRequests.newCoursesConfigue()
        
        RootAssembly.coreAssembly.coursesRequestSender.send(
            with: ["content-type": "application/json"],
            with: arguments,
            config: courseRequestConfigue) {  (result: Result<CoursesResponse, NetworkError>) in
            switch result {
            case .success(let response):
                resultHandler(response, nil)
            case .failure(let error):
                resultHandler(nil, error)
            }
        }
    }
}
