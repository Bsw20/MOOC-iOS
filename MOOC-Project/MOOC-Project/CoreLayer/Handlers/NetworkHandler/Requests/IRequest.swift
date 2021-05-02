//
//  IRequest.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 23.04.2021.
//

import Foundation

protocol IRequest {
    func getUrlRequest(headArguments: [String:String]?,
                       bodyArguments: [String: String]?) -> URLRequest?
}
