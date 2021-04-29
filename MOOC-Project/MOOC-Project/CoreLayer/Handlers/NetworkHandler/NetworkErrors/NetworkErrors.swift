//
//  NetworkErrors.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 25.04.2021.
//

import Foundation

/*Errors that may oocure while working with server part*/

public enum NetworkError: Error {
    // unable to parse URL from string-version
    case badUrl(message: String)
    // unable to receive session
    case badSession(message: String)
    // unable to parse reeceived data
    case badDataWhileParsing(message: String)
    // ptoblems with session
    case badResponse(message: String)
    // some error http=code
    case badCode(code: Int)
    // unknown error occurried
    case unknownError(message: String)
}
