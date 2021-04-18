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
class KeychainWrapper {
    /**
     Function to save password for account in KeyChain Data Base as Generic Password
     */
    func storeGenericPasswordFor(account: String, service: String, password: String) throws {
        
        guard let passwordData = password.data(using: .utf8) else {
            throw KeychainWrapperError(type: .badData)
        }
        
        // creating a query to keyChain
        let query: [String: Any] = [
            // must be encrypted
            kSecClass as String: kSecClassGenericPassword,
            // userName (account name)
            kSecAttrAccount as String: account,
            // purpose of the password, for example, “user login”
            kSecAttrService as String: service,
            // converted to data password
            kSecValueData as String: passwordData
        ]
        
        // execute query and store add password in KeyChain (OSStatus)
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        // if successfully - break, else throw error
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            try updateGenericPasswordFor(
                account: account,
                service: service,
                password: password)
        default:
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
    
    /**
     Function to search password for current account
     */
    func getGenericPasswordFor(account: String, service: String) throws -> String {
        // creating a query to search
        let query: [String: Any] = [
            // encryption enabled
            kSecClass as String: kSecClassGenericPassword,
            // unique identifier for a password in KeyChain
            kSecAttrAccount as String: account,
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
        
        //checking for status of an item
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
    
    func updateGenericPasswordFor( account: String, service: String, password: String) throws {
        guard let passwordData = password.data(using: .utf8) else {
            print("Error converting value to data.")
            // add keyChain error
            return
        }
        
        // creating query to update password
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            // unique id in KeyChain DataBase
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        // target attributes to change (dictionary for changes)
        let attributes: [String: Any] = [
            kSecValueData as String: passwordData
        ]
        
        // execution of a query
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        //checking status
        guard status != errSecItemNotFound else {
            throw KeychainWrapperError(
                message: "Matching Item Not Found",
                type: .itemNotFound)
        }
        guard status == errSecSuccess else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
    
    func deleteGenericPasswordFor(account: String, service: String) throws {
        // creating query to delete stored password
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        // NOTE: do not forget to specify which item to delete or all items will be deleted
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainWrapperError(status: status, type: .servicesError)
        }
    }
}

