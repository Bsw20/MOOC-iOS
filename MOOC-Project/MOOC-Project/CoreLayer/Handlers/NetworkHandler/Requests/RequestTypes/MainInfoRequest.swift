//
//  MainInfoRequest.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 08.05.2021.
//

import Foundation

class MainInfoRequest: IRequest {
    
    private var baseURL: String = "https://api.mooc.ij.je/courses/main"
        
    func setRequestConfigue(url: URL,
                            headArguments: [String: String]?,
                            bodyArguments: [String: String]?)
    -> URLRequest {
        
        var request = URLRequest(url: url, timeoutInterval: 5)
        
        request.httpMethod = "GET"
        
        if let headArguments = headArguments {
            request.allHTTPHeaderFields = headArguments
        }
        // print(url.absoluteURL)
        // print(String(decoding: request.httpBody ?? Data(), as: UTF8.self))
        return request
    }
    
    func getUrlRequest(headArguments: [String: String]?,
                       bodyArguments: [String: String]?) -> URLRequest? {
        guard let url = URL(string: baseURL) else {return nil}
        return setRequestConfigue(url: url,
                                  headArguments: headArguments,
                                  bodyArguments: nil)
    }
}
