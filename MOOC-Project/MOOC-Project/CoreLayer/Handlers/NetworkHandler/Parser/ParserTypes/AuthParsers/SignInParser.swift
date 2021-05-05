//
//  SignIn.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 26.04.2021.
//

import Foundation

struct SignInResponse: Decodable {
    let accessToken: String?
    let refreshToken: String?
    let user: UserResponse?
    let error: String?
}

struct UserResponse: Decodable {
    var username: String?
    var email: String?
}

class SignInParser: IParser {    
    func parse(data: Data) -> SignInResponse? {
        do {
            return  try JSONDecoder().decode(SignInResponse.self, from: data)
        } catch {
            Logger.logNetWork(description: "FAILED TO PARSE SIGN IN RESPONSE: \n\(error.localizedDescription)",
                              logType: .error)
            return nil
        }
    }
}
