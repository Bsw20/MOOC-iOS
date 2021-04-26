//
//  SignUpModelProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 25.04.2021.
//

import SwiftUI

protocol SignUpProtocol {
    func validateUserName(userName: String) -> Bool
    func validateEmail(email: String) -> Bool
    func validateAll(email: String,
                     userName: String,
                     password: String) -> Bool
    
    func signUpUser(userData: UserDataModel,
                    resultHandler: @escaping (NetworkError?) -> Void)
}
