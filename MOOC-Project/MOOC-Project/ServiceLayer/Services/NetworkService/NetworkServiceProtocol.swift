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
                    resultHandler: @escaping (CoursesResponse?, NetworkError?) -> Void)
    func getActualCategories(resultHandler: @escaping ([Category]?, NetworkError?) -> Void)
    func logOut()
}
