//
//  SearchModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import SwiftUI

class SearchModel {
        
    func receiveCategories(result: @escaping([TouchableChip]) -> Void) {
        RootAssembly.serviceAssembly.networkService.getActualCategories { response, _ in
            guard let response = response else {
                result([])
                return
            }
            var categories: [TouchableChip] = []
            for category in response {
                guard
                    let ruName = category.name.ru else {continue}
                categories.append(.init(isSelected: false, titleKey: ruName))
            }
            result(categories)
        }
    }
    
    func receiveCourseDetails(id: String, result: @escaping(Result<GeneralParsedCourseDataModel, NetworkError>) -> Void) {
        RootAssembly.serviceAssembly.networkService.getCourse(id: id) { innerRes in
            switch innerRes {
            case .success(let response):
                guard let parsed = response
                else {
                    // TODO. логгирование ошибки парсинга
                    result(.failure(.badCode(code: 13)))
                    return
                }
                result(.success(parsed))
            case .failure(let error):
                result(.failure(error))
                // TODO. логгирование
                print(error.localizedDescription)
            }
        }
    }
    
    func searchRequest(
        with stringQuery: String,
        categories: [Int],
        pageNumber: Int,
        pageSize: Int,
        resultHandler: @escaping(GeneralParsedCoursesDataModel?, NetworkError?) -> Void) {
        
        RootAssembly.serviceAssembly.networkService.getCourses(
            arguments: ["pageSize": String(pageSize),
                        "pageNumber": String(pageNumber),
                        "searchQuery": stringQuery,
                        "categories": getCategories(categories: categories)]) { response, error in
            resultHandler(response, error)
        }
    }
    
    func getReviewsForCourse(courseId: String, result: @escaping(Result<CourseReviewsParsedDataModel, NetworkError>) -> Void) {
        RootAssembly.serviceAssembly.networkService.getReviewsToCourse(courseId: courseId) { innerResult in
            switch innerResult {
            case .success(let response):
                guard let parsed = response
                else {
                    // TODO. логгировать на парсинг
                    result(.failure(.badCode(code: 13)))
                    return
                }
                result(.success(parsed))
                
            case .failure(let error):
                result(.failure(error))
                // TODO. логгирование
                print(error.localizedDescription)
            }
        }
    }
    
    func checkReviewForOwnerShip(userName: String) -> Bool {
        guard let login = RootAssembly.serviceAssembly.informationService.getData()?.login,
              login == userName
              else {return false}
        return true
    }
    
    func addToFavourites(id: String, result: @escaping(NetworkError?) -> Void) {
        RootAssembly.serviceAssembly.networkService.addToFavorites(id: id, resultHandler: result)
    }
    
    func deleteFromFavourites(id: String, result: @escaping(NetworkError?) -> Void) {
        RootAssembly.serviceAssembly.networkService.deleteFromFavorites(id: id, resultHandler: result)
    }
    
    func addToViewed(id: String, result: @escaping(NetworkError?) -> Void) {
        RootAssembly.serviceAssembly.networkService.addToViewed(id: id, resultHandler: result)
    }
    
    func deleteFromViewed(id: String, result: @escaping(NetworkError?) -> Void) {
        RootAssembly.serviceAssembly.networkService.deleteFromViewed(id: id, resultHandler: result)
    }
    
    func deleteReview(reviewId: String, result: @escaping(NetworkError?) -> Void) {
        RootAssembly.serviceAssembly.networkService.deleteReviewForCourse(reviewId: reviewId, resultHandler: result)
    }
    
    func addReview(id: String, rating: Double, text: String, result: @escaping(NetworkError?) -> Void) {
        RootAssembly.serviceAssembly.networkService.addReviewForCourse(id: id, rating: rating, text: text, resultHandler: result)
    }
    
    private func getCategories(categories: [Int]) -> String {
        let sortedCategories = categories.sorted()
        return sortedCategories.compactMap({ "\($0)"}).joined(separator: ",")
    }
}
