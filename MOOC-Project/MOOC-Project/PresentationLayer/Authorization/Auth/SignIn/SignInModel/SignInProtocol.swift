//
//  SignInProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 26.04.2021.
//

import Foundation

protocol SignInProtocol {
    func userNameOrEmailValidation(fieldValue: String) -> Bool
    func createUserData(fieldValue: String, password: String) -> UserDataModel
    func signInUser(userData: UserDataModel, resultHandler: @escaping (NetworkError?) -> Void)
    func validateAll(fieldValue: String, password: String) -> Bool
    func changeSessionStatus()
}
