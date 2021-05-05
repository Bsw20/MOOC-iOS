//
//  FavouriteRequest.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

enum FavouriteRequestType: String {
    case post = "POST"
    case delete = "DELETE"
    case get = "GET"
}

class FavouriteRequest: IRequest {
   
    private var baseURL: String = "https://api.mooc.ij.je/users/favourite"
    private var type: FavouriteRequestType
    
    private func queryBuilder(with bodyArguments: [String: String]?) -> String {
        guard let bodyArguments = bodyArguments else {
            Logger.logNetWork(description: "QUERY BUILDER HAS NO ARGUMENTS - FAVOURITE COURSE REQUEST", logType: .warning)
            return ""
        }
        return "?id=\(bodyArguments["id"] ?? "")"
    }
    
    init(type: FavouriteRequestType) {
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
        
        request.httpMethod = self.type.rawValue
                
        if let headArguments = headArguments {
            request.allHTTPHeaderFields = headArguments
        }
        
        // print(String(decoding: request.httpBody ?? Data(), as: UTF8.self))
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

