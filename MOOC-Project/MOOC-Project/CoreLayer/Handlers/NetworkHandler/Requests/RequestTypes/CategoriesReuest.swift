//
//  CategoriesReuest.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

class CategoriesRequest: IRequest {
    
    private var baseURL: String = "https://mooc.ij.je/categories/"
   
    
    /**
     Setting up a post-request to send auth-info to the server.
     */
    private func setRequestConfigue(url: URL,
                                    headArguments: [String: String]?,
                                    bodyArguments: [String: String]?)
    -> URLRequest {
        
        var request = URLRequest(url: url, timeoutInterval: 5)
        
        request.httpMethod = "GET"
        
        if let headArguments = headArguments {
            request.allHTTPHeaderFields = headArguments
        }
        
        if let bodyArguments = bodyArguments {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyArguments, options: .prettyPrinted)
        }
        
        return request
    }
    
    func getUrlRequest(headArguments: [String: String]?,
                       bodyArguments: [String: String]?) -> URLRequest? {
        
        guard let url = URL(string: baseURL) else {return nil}
        return setRequestConfigue(url: url,
                                  headArguments: headArguments,
                                  bodyArguments: bodyArguments)
    }
}
