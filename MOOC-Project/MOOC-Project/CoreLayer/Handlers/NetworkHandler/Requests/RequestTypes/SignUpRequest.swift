//
//  Request.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 23.04.2021.
//To print data
//print(String(decoding: request.httpBody!, as: UTF8.self))

import Foundation

class SignUpRequest: IRequest {
    
    private var baseURL: String = "https://mooc.ij.je/auth/signup"
    
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
        
        return request
    }
    
    /*Function to receive new request according to new arguments*/
    public func getUrlRequest(bodyArguments: [String: String]?) -> URLRequest? {
        guard let url = URL(string: baseURL) else {return nil}
        return setRequestConfigue(url: url, bodyArguments: bodyArguments)
    }
}
