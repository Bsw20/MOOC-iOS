////
////  JWTTokenHandler.swift
////  MOOC-Project
////
////  Created by Андрей Самаренко on 23.04.2021.
////
//
//import Foundation
//
//class JWTTokenHandler {
//
//    var accessToken: String?
//    var refreshToken: String?
//
//    func initTokens(tokensMissingHandler: @escaping () -> (accessToken: String, refreshToken: String)) {
//        if let accessToken = getAccessTokenFromStore(),
//           let refreshToken = getRefreshTokenFromStore() {
//
//            self.accessToken = accessToken
//            self.refreshToken = refreshToken
//
//        } else {
//            let pair = tokensMissingHandler()
//            self.accessToken = pair.accessToken
//            self.refreshToken = pair.refreshToken
//        }
//    }
//
//    private func getAccessTokenFromStore() -> String? {
//        do {
//           return try RootAssembly.serviceAssembly.keyChainStoreJWT.getGenericJWTTokenFor(
//            tokenName: "accessToken",
//            service: "access")
//        } catch let error as KeychainWrapperError {
//            Logger.warning(fullDescription: error.message ?? "<CAN'T RECEIVE MESSAGE - ACCESS TOKEN>")
//        } catch {
//            Logger.warning(fullDescription: error.localizedDescription)
//        }
//        return nil
//    }
//
//    private func getRefreshTokenFromStore() -> String? {
//        do {
//            return try RootAssembly.serviceAssembly.keyChainStoreJWT.getGenericJWTTokenFor(
//                tokenName: "refreshToken",
//                service: "refresh")
//        } catch let error as KeychainWrapperError {
//            Logger.warning(fullDescription: error.message ?? "<CAN'T RECEIVE MESSAGE - REFRESH TOKEN>")
//        } catch {
//            Logger.warning(fullDescription: error.localizedDescription)
//        }
//        return nil
//    }
//}
