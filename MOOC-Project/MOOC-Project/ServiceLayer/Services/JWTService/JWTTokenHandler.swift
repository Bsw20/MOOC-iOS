//
//  JWTTokenHandler.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 23.04.2021.
//

 import Foundation

enum TokenType: String {
    case accessToken
    case refreshToken
}

class JWTTokenHandler: JWTTokenHandlerProtocol {
    
    private var accessTokenValue: String?
    private var refreshTokenValue: String?
    
    func updateToken(tokenType: TokenType, tokenValue: String) {
        switch tokenType {
        case .accessToken:
            accessTokenValue = tokenValue
            updateTokenInStore(tokenType: .accessToken, service: "access", tokenValue: tokenValue)
        case .refreshToken:
            refreshTokenValue = tokenValue
            updateTokenInStore(tokenType: .refreshToken, service: "refresh", tokenValue: tokenValue)
        }
    }
    
    func getToken(tokenType: TokenType) -> String? {
        switch tokenType {
        case .accessToken:
            if let value = accessTokenValue {
                return value
            } else {
                return getTokenFromStore(tokenType: .accessToken, service: "access")
            }
        case .refreshToken:
            if let value = refreshTokenValue {
                return value
            } else {
                return getTokenFromStore(tokenType: .refreshToken, service: "refresh")
            }
        }
    }
    
    private func getTokenFromStore(
        tokenType: TokenType,
        service: String)
    -> String? {
        do {
           return try RootAssembly.serviceAssembly.keyChainStoreJWT.getGenericJWTTokenFor(
            tokenName: tokenType.rawValue,
            service: service)
        } catch let error as KeychainWrapperError {
            Logger.logJWT(
                description: "\(tokenType.rawValue.capitalized) TOKEN NOT FOUND IN KEYCHAIN: \(error.message ?? "UNKNOWN MESSAGE")",
                logType: .error)
        } catch {
            Logger.logJWT(
                description: "UNDEFINED BEHAVIOUR IN KEYCHAIN - GET: \(error.localizedDescription)",
                logType: .error)
        }
        return nil
    }
    
    private func updateTokenInStore(
        tokenType: TokenType,
        service: String,
        tokenValue: String) {
        
        do {
            let oldValue = try? RootAssembly.serviceAssembly.keyChainStoreJWT.getGenericJWTTokenFor(
                tokenName: tokenType.rawValue,
                service: (tokenType == .accessToken ? "access" : "refresh"))
            
           try RootAssembly.serviceAssembly.keyChainStoreJWT.storeGenericJWTTokenFor(
            tokenName: tokenType.rawValue,
                service: service,
                tokenValue: tokenValue)
            Logger.logJWT(description: "TOKEN: \(tokenType.rawValue.capitalized) SUCCESSFULLY UPDATED:"
                + "{\n\tOLD VALUE: \(oldValue ?? "NO VALUE")"
                + "\n\tNEW VALUE: \(tokenValue)\n\t}",
                          logType: .success)
        } catch let error as KeychainWrapperError {
            Logger.logJWT(
                description: "\(tokenType.rawValue.capitalized) FAILED TO UPDATE IN KEYCHAIN: \(error.message ?? "UNKNOWN MESSAGE")",
                logType: .error)
        } catch {
            Logger.logJWT(
                description: "UNDEFINED BEHAVIOUR IN KEYCHAIN - UPDATE: \(error.localizedDescription)",
                logType: .error)
        }
    }
 }
