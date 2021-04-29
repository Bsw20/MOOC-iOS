//
//  SignRequest.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 26.04.2021.
//

import Foundation

enum SignRequestType: String {
    case signIn = "signin"
    case signUp = "signup"
}

/*
 Base class for all sign-requests
 */
class SignRequest: IRequest {
    
    private var baseURL: String = "https://mooc.ij.je/auth/"
    private var type: SignRequestType
    
    init(type: SignRequestType) {
        self.type = type
    }
    
    /**
     Setting up a post-request to send auth-info to the server.
     */
    private func setRequestConfigue(url: URL,
                                    bodyArguments: [String: String]?)
    -> URLRequest {
        
        var request = URLRequest(url: url, timeoutInterval: 5)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "content-type": "application/json"
        ]
        
        if let bodyArguments = bodyArguments {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyArguments, options: .prettyPrinted)
        }
        
        // print(String(decoding: request.httpBody ?? Data(), as: UTF8.self))
        return request
    }
    
    func getUrlRequest(bodyArguments: [String: String]?) -> URLRequest? {
        guard let url = URL(string: baseURL + type.rawValue) else {return nil}
        return setRequestConfigue(url: url, bodyArguments: bodyArguments)
    }
}
