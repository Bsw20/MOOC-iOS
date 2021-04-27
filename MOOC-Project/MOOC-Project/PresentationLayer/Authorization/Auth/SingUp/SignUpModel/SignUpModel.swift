//
//  SignUpModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 25.04.2021.
//

import SwiftUI

class SignUpModel: SignUpProtocol {
    
    func validateUserName(userName: String) -> Bool {
        return RootAssembly.serviceAssembly.signValidation.isValidUserName(userName: userName)
    }
    
    func validateEmail(email: String) -> Bool {
        return RootAssembly.serviceAssembly.signValidation.isValidEmail(email: email)
    }
    
    func validateAll(email: String,
                     userName: String,
                     password: String) -> Bool {
        return RootAssembly.serviceAssembly.signValidation.isEnableToContinue(
            userName: userName,
            email: email,
            password: password)
    }
    
    func signUpUser(userData: UserDataModel,
                    resultHandler: @escaping (NetworkError?) -> Void) {
        RootAssembly.serviceAssembly.networkService.signUpUser(
            userData: userData) { (error: NetworkError?) in
            DispatchQueue.main.sync {
                resultHandler(error)
            }
        }
    }
    
    func changeSessionStatus() {
        RootAssembly.serviceAssembly.sessionService.setCurrentSessionValue(for: "status", value: true)
    }
}
