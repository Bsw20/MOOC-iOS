//
//  Request.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 23.04.2021.
//

import Foundation

class SignUpRequest: IRequest {
    
    private var baseURL: String = "https://mooc.ij.je/"

    init(){
        baseURL +=
    }
    
    public var urlRequest: URLRequest? {
        guard let url = URL(string: baseURL) else {return nil}
        return URLRequest(url: url, timeoutInterval: 5)
    }
    
}
