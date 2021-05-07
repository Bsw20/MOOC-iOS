//
//  InformationSavingHandler.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

class InformationSavingHandler: InformationSavingHandlerProtocol {
    private let email = "userEmail"
    private let login = "userLogin"
    
    func setInformation(userEmail: String, userLogin: String) {
        UserDefaults.standard.setValue(userEmail, forKey: email)
        UserDefaults.standard.setValue(userLogin, forKey: login)
        UserDefaults.standard.synchronize()
    }
    
    func getInformation() -> (email: String, login: String)? {
        guard let storedEmail = UserDefaults.standard.value(forKey: email) as? String,
              let storedLogin = UserDefaults.standard.value(forKey: login) as? String
        else {
            return nil
        }
        return (storedEmail, storedLogin)
    }
}
