//
//  KeyChainWrapper.swift
//  MOOC
//
//  Created by Андрей Самаренко on 06.04.2021.
//

import Foundation

/**
 Class provides interface for interaction with KeyChain data base.
 */
class KeychainWrapper: KeyChainWrapperProtocol {
    /**
     Function to save password for account in KeyChain Data Base as Generic Password
     */
    func storeGenericJWTTokenFor(tokenName: String, service: String, tokenValue: String) throws {
        
        guard let tokenData = tokenValue.data(using: .utf8) else {
            throw KeychainWrapperError(type: .badData)
        }
        
        // creating a query to keyChain
        let query: [String: Any] = [
            // must be encrypted
            kSecClass as String: kSecClassGenericPassword,
            // userName (account name)
            kSecAttrAccount as String: tokenName,
            // purpose of the password, for example, “user login”
            kSecAttrService as String: service,
            // converted to data password
            kSecValueData as String: tokenData
        ]
        
        // execute query and store add password in KeyChain (OSStatus)
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        // if successfully - break, else throw error
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            try updateGenericJWTTokenFor(
                tokenName: tokenName,
                service: service,
                token: tokenValue)
        default:
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
    
    /**
     Function to search password for current account
     */
    func getGenericJWTTokenFor(tokenName: String, service: String) throws -> String {
        // creating a query to search
        let query: [String: Any] = [
            // encryption enabled
            kSecClass as String: kSecClassGenericPassword,
            // unique identifier for a password in KeyChain
            kSecAttrAccount as String: tokenName,
            kSecAttrService as String: service,
            // single item expected
            kSecMatchLimit as String: kSecMatchLimitOne,
            // to return all data and attributes for the found value
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        // search logic with item to store received data
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        // checking for status of an item
        guard status != errSecItemNotFound else {
            throw KeychainWrapperError(type: .itemNotFound)
        }
        guard status == errSecSuccess else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
        
        // extracting password from received data
        guard
            let existingItem = item as? [String: Any],
            let valueData = existingItem[kSecValueData as String] as? Data,
            let value = String(data: valueData, encoding: .utf8)
        else {
            throw KeychainWrapperError(type: .unableToConvertToString)
        }
        return value
    }
    
    func updateGenericJWTTokenFor(tokenName: String, service: String, token: String) throws {
        guard let tokenData = token.data(using: .utf8) else {
            print("Error converting value to data.")
            // add keyChain error
            return
        }
        
        // creating query to update password
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            // unique id in KeyChain DataBase
            kSecAttrAccount as String: tokenName,
            kSecAttrService as String: service
        ]
        
        // target attributes to change (dictionary for changes)
        let attributes: [String: Any] = [
            kSecValueData as String: tokenData
        ]
        
        // execution of a query
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        // checking status
        guard status != errSecItemNotFound else {
            throw KeychainWrapperError(
                message: "Matching Item Not Found",
                type: .itemNotFound)
        }
        guard status == errSecSuccess else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
    
    func deleteGenericJWTTokenFor(tokenName: String, service: String) throws {
        // creating query to delete stored password
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenName,
            kSecAttrService as String: service
        ]
        
        // NOTE: do not forget to specify which item to delete or all items will be deleted
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
}
