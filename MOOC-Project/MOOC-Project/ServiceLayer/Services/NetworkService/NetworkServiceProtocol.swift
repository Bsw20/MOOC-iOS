//
//  NetworkServiceProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 24.04.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func signUpUser(userData: UserDataModel,
                    resultHandler: @escaping (NetworkError?) -> Void)
    func signInUser(userData: UserDataModel,
                    resultHandler: @escaping (NetworkError?) -> Void)
    func refreshToken(resultHandler: @escaping () -> Void)
    func getCourses(arguments: [String: String],
                    resultHandler: @escaping (GeneralParsedCoursesDataModel?, NetworkError?) -> Void)
    func getActualCategories(resultHandler: @escaping ([CourseResponseCategoryDataModel]?, NetworkError?) -> Void)
    func getCourse(id: String, resultHandler: @escaping (Result<GeneralParsedCourseDataModel?, NetworkError>) -> Void)
    func deleteFromFavorites(id: String, resultHandler: @escaping(NetworkError?) -> Void)
    func getViewedCourses(resultHandler: @escaping ([CourseParsedShortDataModel]?, NetworkError?) -> Void)
    func getFavoritesCourses(resultHandler: @escaping ([CourseParsedShortDataModel]?, NetworkError?) -> Void) 
    func addToFavorites(id: String, resultHandler: @escaping(NetworkError?) -> Void)
    func deleteFromViewed(id: String, resultHandler: @escaping(NetworkError?) -> Void)
    func addToViewed(id: String, resultHandler: @escaping(NetworkError?) -> Void)
    func deleteReviewForCourse(reviewId: String, resultHandler: @escaping(NetworkError?) -> Void)
    func addReviewForCourse(id: String, rating: Double, text: String, resultHandler: @escaping(NetworkError?) -> Void)
    func getReviewsToCourse(courseId: String, resultHandler: @escaping(Result<CourseReviewsParsedDataModel?, NetworkError>) -> Void)
    
    func logOut(resultHandler: @escaping() -> Void)
}
