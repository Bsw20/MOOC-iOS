//
//  CourseRequest.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

/*
 Base class for all course-requests
 */
class CourseRequest: IRequest {
    
    private var baseURL: String = "https://mooc.ij.je/courses/"
    
    private func queryBuilder(with bodyArguments: [String: String]?) -> String {
        guard let bodyArguments = bodyArguments else {
            Logger.logNetWork(description: "QUERY BUILDER HAS NO ARGUMENTS - COURSE REQUEST", logType: .warning)
            return "?"
        }
        return "?" + bodyArguments.compactMap({ "\($0.key)=\($0.value)"}).joined(separator: "&")
    }
    
    private func setRequestConfigue(url: URL,
                                    headArguments: [String: String]?)
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
        guard let url = URL(string: baseURL + queryBuilder(with: bodyArguments)) else {return nil}
        return setRequestConfigue(url: url,
                                  headArguments: headArguments)
    }
}
