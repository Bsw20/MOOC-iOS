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
            with: [
                "email": email,
                "username": userName,
                "password": userData.password
            ],
            
            config: signUpRequestConfigue) { (result: Result<SignUpResponse, NetworkError>) in
            
            switch result {
            case .success:
                resultHandler(nil)
            case .failure(let error):
                resultHandler(error)
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
            with: body,
            config: signInRequestConfigue) { (result: Result<SignInResponse, NetworkError>) in
            
            switch result {
            case .success(let response):
                guard
                    let accessToken = response.accessToken,
                    let refreshToken = response.refreshToken
                else {
                    resultHandler(.badDataWhileParsing(message: "NO TOKENS"))
                    return
                }
                RootAssembly.serviceAssembly.jwtTokenHandler.updateToken(tokenType: .accessToken, tokenValue: accessToken)
                RootAssembly.serviceAssembly.jwtTokenHandler.updateToken(tokenType: .refreshToken, tokenValue: refreshToken)
                resultHandler(nil)
            case .failure(let error):
                resultHandler(error)
            }
            
        }
    }
}
