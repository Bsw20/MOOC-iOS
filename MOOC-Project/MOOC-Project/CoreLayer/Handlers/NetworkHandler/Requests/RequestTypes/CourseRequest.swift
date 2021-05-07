//
//  DetailedCourseInfoRequest.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 03.05.2021.
//

import Foundation

class CourseRequest: IRequest {
    
    var baseURL: String = "https://api.mooc.ij.je/courses/"
    
    private func queryBuilder(with bodyArguments: [String: String]?) -> String {
        guard let bodyArguments = bodyArguments else {
            Logger.logNetWork(description: "QUERY BUILDER HAS NO ARGUMENTS - DETAILED COURSE REQUEST", logType: .warning)
            return ""
        }
        return bodyArguments["id"] ?? ""
    }
    
    func setRequestConfigue(url: URL,
                            headArguments: [String: String]?,
                            bodyArguments: [String: String]?)
    -> URLRequest {
        
        var request = URLRequest(url: url, timeoutInterval: 5)
        request.httpMethod = "GET"
        
        if let headArguments = headArguments {
            request.allHTTPHeaderFields = headArguments
        }
        
        return request
    }
    
    func getUrlRequest(headArguments: [String: String]?,
                       bodyArguments: [String: String]?) -> URLRequest? {
        
        guard let url = URL(string: baseURL + queryBuilder(with: bodyArguments)) else {return nil}
        return setRequestConfigue(url: url,
                                  headArguments: headArguments,
                                  bodyArguments: nil)
    }
}
