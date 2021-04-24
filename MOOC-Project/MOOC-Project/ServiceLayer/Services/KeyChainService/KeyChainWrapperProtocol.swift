//
//  KeyChainWrapperProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 23.04.2021.
//

import Foundation

protocol KeyChainWrapperProtocol {
    
    func storeGenericJWTTokenFor(tokenName: String, service: String, tokenValue: String) throws 
    func getGenericJWTTokenFor(tokenName: String, service: String) throws -> String
    func updateGenericJWTTokenFor(tokenName: String, service: String, token: String) throws
    func deleteGenericJWTTokenFor(tokenName: String, service: String) throws
    
}
