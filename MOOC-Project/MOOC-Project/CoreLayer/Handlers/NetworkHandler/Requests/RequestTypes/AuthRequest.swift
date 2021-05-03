//
//  SignRequest.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 26.04.2021.
//

import Foundation

enum AuthRequestType: String {
    case signIn = "signin"
    case signUp = "signup"
    case refreshToken = "refresh-token"
    case logout = "logout"
}

/*
 Base class for all sign-requests
 */
class AuthRequest: IRequest {
   
    private var baseURL: String = "https://api.mooc.ij.je/auth/"
    private var type: AuthRequestType
    
    init(type: AuthRequestType) {
        self.type = type
    }
    
    /**
     Setting up a post-request to send auth-info to the server.
     */
    func setRequestConfigue(url: URL,
                            headArguments: [String: String]?,
                            bodyArguments: [String: String]?)
    -> URLRequest {
        
        var request = URLRequest(url: url, timeoutInterval: 5)
        
        request.httpMethod = "POST"
        
        if let headArguments = headArguments {
            request.allHTTPHeaderFields = headArguments
        }
        
        if let bodyArguments = bodyArguments {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyArguments, options: .prettyPrinted)
        }
        
        // print(String(decoding: request.httpBody ?? Data(), as: UTF8.self))
        return request
    }
    
    func getUrlRequest(headArguments: [String: String]?,
                       bodyArguments: [String: String]?) -> URLRequest? {
        
        guard let url = URL(string: baseURL + type.rawValue) else {return nil}
        return setRequestConfigue(url: url,
                                  headArguments: headArguments,
                                  bodyArguments: bodyArguments)
    }
}
