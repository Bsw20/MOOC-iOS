//
//  SignInModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 26.04.2021.
//

import Foundation

class SignInModel: SignInProtocol {
    
    func userNameOrEmailValidation(fieldValue: String) -> Bool {
        return
            RootAssembly.serviceAssembly.signValidation.isValidEmail(email: fieldValue)
        ||
            RootAssembly.serviceAssembly.signValidation.isValidUserName(userName: fieldValue)
    }
    
    func signInUser(userData: UserDataModel, resultHandler: @escaping (NetworkError?) -> Void) {
        RootAssembly.serviceAssembly.networkService.signInUser(userData: userData) { error in
            DispatchQueue.main.sync {
                resultHandler(error)
            }
        }
    }
    
    func createUserData(fieldValue: String, password: String) -> UserDataModel {
        return (RootAssembly.serviceAssembly.signValidation.isValidEmail(email: fieldValue)
                    ? .init(email: fieldValue, password: password)
                    : .init(userName: fieldValue, password: password))
    }
    
    func validateAll(fieldValue: String, password: String) -> Bool {
        return userNameOrEmailValidation(fieldValue: fieldValue)
            && RootAssembly.serviceAssembly.signValidation.isValidPassword(password: password)
    }
}
