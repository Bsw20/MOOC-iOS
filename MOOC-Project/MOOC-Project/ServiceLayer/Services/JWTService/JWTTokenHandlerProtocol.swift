//
//  JWTTokenHandlerProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 26.04.2021.
//

import Foundation

protocol JWTTokenHandlerProtocol {
    func updateToken(
        tokenType: TokenType,
        tokenValue: String)
    func getToken(tokenType: TokenType) -> String?
}
