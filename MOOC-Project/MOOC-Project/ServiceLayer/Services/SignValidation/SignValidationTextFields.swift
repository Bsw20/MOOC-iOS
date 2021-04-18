//
//  SignValidationTextFields.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 18.04.2021.
//

import Foundation

protocol SignValidationTextFieldsProtocol {
    func isValidUserName(userName: String) -> Bool
    func isValidEmail(email: String) -> Bool
    func isValidPassword(password: String) -> Bool
    func isEnableToContinue(userName: String, email: String, password:String) -> Bool
}

class SignValidationTextFields: SignValidationTextFieldsProtocol {
    func isValidUserName(userName: String) -> Bool {
        return !userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print(emailPred.evaluate(with: email))
        return emailPred.evaluate(with: email)
    }
    
    /**
     TODO. переделать чуть позже - подумать что для пароля может быть ограничением
     */
    func isValidPassword(password: String) -> Bool{
        return !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func isEnableToContinue(userName: String, email: String, password:String) -> Bool {
        return isValidEmail(email: email)
            && isValidUserName(userName: userName)
            && isValidPassword(password: password)
        
    }

}
