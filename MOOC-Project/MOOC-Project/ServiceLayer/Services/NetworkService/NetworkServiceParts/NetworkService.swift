//
//  NetworkService.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 24.04.2021.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    func signUpUser(userData: UserDataModel,
                    resultHandler: @escaping (NetworkError?) -> Void) {
        
        let signUpRequestConfigue = RequestFactory.AuthRequests.newSignUpConfigue()
        
        guard
            let email = userData.email,
            let userName = userData.userName else {
            return
        }
        
        RootAssembly.coreAssembly.signUpRequestSender.send(
            with:
                ["content-type": "application/json"],
            with: [
                "email": email,
                "username": userName,
                "password": userData.password
            ],
            
            config: signUpRequestConfigue) { (result: Result<SignUpResponse, NetworkError>) in
            
            switch result {
            case .success:
                self.signInUser(userData: userData, resultHandler: resultHandler)
            case .failure(let error):
                resultHandler(error)
            }
        }
    }
    
    func refreshToken(resultHandler: @escaping () -> Void) {
        let resfreshConfigue = RequestFactory.AuthRequests.newTokenRefreshConfigure()
        
        let headers = ["content-type": "application/json",
                        "x-refresh-token": RootAssembly.serviceAssembly.jwtTokenHandler.getToken(tokenType: .refreshToken) ?? "NONE"]
        
        RootAssembly.coreAssembly.tokenRequestSender.send(
            with: headers,
            with: nil,
            config: resfreshConfigue) { (result: Result<RefreshTokenResponse, NetworkError>) in
            
            switch result {
            case .success(let response):
                
                guard
                    let accessToken = response.accessToken,
                    let refreshToken = response.refreshToken
                else {
                    Logger.logNetWork(description: "NO TOKENS RECEIVED", logType: .error)
                    return
                }
                
                RootAssembly.serviceAssembly.jwtTokenHandler.updateToken(tokenType: .accessToken,
                                                                         tokenValue: accessToken)
                RootAssembly.serviceAssembly.jwtTokenHandler.updateToken(tokenType: .refreshToken,
                                                                         tokenValue: refreshToken)
                
                resultHandler()
                
            case .failure(let error):
                Logger.logNetWork(description: "FAILED TO REFRESH TOKEN\nDESCRIPTION:\(error.localizedDescription)",
                                  logType: .error)
                RootAssembly.serviceAssembly.sessionService.setCurrentSessionValue(for: "status", value: false)
            }
        }
    }
    
    func signInUser(userData: UserDataModel,
                    resultHandler: @escaping (NetworkError?) -> Void) {
        
        let signInRequestConfigue = RequestFactory.AuthRequests.newSignInCofigure()
        
        var body: [String: String] = [:]
        
        if let email = userData.email {
            body = [
                "email": email,
                "password": userData.password
            ]
        } else if let username = userData.userName {
            body = [
                "username": username,
                "password": userData.password
            ]
        }
        
        RootAssembly.coreAssembly.signInRequestSender.send(
            with:
                ["content-type": "application/json"],
            with: body,
            config: signInRequestConfigue) { (result: Result<SignInResponse, NetworkError>) in
            
            switch result {
            case .success(let response):
                guard
                    let accessToken = response.accessToken,
                    let refreshToken = response.refreshToken,
                    let user = response.user,
                    let email = user.email,
                    let name = user.username
                else {
                    resultHandler(.badDataWhileParsing(message: "NO TOKENS or DATA"))
                    return
                }
                RootAssembly.serviceAssembly.jwtTokenHandler.updateToken(tokenType: .accessToken, tokenValue: accessToken)
                RootAssembly.serviceAssembly.jwtTokenHandler.updateToken(tokenType: .refreshToken, tokenValue: refreshToken)
                RootAssembly.serviceAssembly.informationService.saveData(email: email, login: name)
                
                resultHandler(nil)
            case .failure(let error):
                resultHandler(error)
            }
            
        }
    }
    
    func logOut() {
        let logOutConfigue = RequestFactory.AuthRequests.newLogOutConfigure()
        let headers = ["content-type": "application/json",
                       "x-refresh-token": RootAssembly.serviceAssembly.jwtTokenHandler.getToken(tokenType: .refreshToken) ?? "NONE"]
        
        RootAssembly.coreAssembly.logOutRequestSender.send(
            with: headers,
            with: nil,
            config: logOutConfigue) { (result: Result<LogOutResponse, NetworkError>) in
            
            switch result {
            case .success:
                Logger.logNetWork(description: "LOG OUT SUCCESSFULLY", logType: .success)
            case .failure(let error):
                Logger.logNetWork(description: "ERROR OCCURIED: \(error.localizedDescription)", logType: .warning)
            }
            RootAssembly.serviceAssembly.sessionService.setCurrentSessionValue(for: "status", value: false)
        }
    }
}
