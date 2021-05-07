//
//  ReviewsRequest.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

enum ReviewRequestType: String {
    case post = "POST"
    case delete = "DELETE"
    case get = "GET"
}

class ReviewsRequest: IRequest {
   
    private var baseURL: String = "https://api.mooc.ij.je/reviews/"
    private var type: ReviewRequestType
    
    private func queryBuilder(with bodyArguments: [String: String]?) -> String {
        guard let bodyArguments = bodyArguments else {
            Logger.logNetWork(description: "QUERY BUILDER HAS NO ARGUMENTS - VIEWED COURSE REQUEST", logType: .warning)
            return ""
        }
        
        switch self.type {
        case .get, .post:
            return "?id=\(bodyArguments["id"] ?? "")"
        case .delete:
            return "?reviewId=\(bodyArguments["reviewId"] ?? "")"
        }
    }
    
    init(type: ReviewRequestType) {
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
        
        if self.type == .post,
           let bodyArguments = bodyArguments {
            let arguments = [
                "rating": bodyArguments["rating"] ?? "",
                "text": bodyArguments["text"] ?? "no text"
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: arguments, options: .prettyPrinted)
        }
        
        request.httpMethod = self.type.rawValue
        
        if let headArguments = headArguments {
            request.allHTTPHeaderFields = headArguments
        }
//        print(url)
//        print(headArguments)
//        print(String(decoding: request.httpBody ?? Data(), as: UTF8.self))
        return request
    }
    
    func getUrlRequest(headArguments: [String: String]?,
                       bodyArguments: [String: String]?) -> URLRequest? {
        
        guard let url = URL(string: baseURL + queryBuilder(with: bodyArguments)) else {return nil}
        return setRequestConfigue(url: url,
                                  headArguments: headArguments,
                                  bodyArguments: bodyArguments)
    }
}

