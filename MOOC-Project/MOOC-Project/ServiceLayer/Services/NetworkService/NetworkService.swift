//
//  NetworkService.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 24.04.2021.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    func signInUser(userData: UserDataModel,
                    resultHandler: @escaping (SignUpResponse?, NetworkError?) -> Void) {
        
        let signUpRequestConfigue = RequestFactory.AuthRequests.newSignUpConfigue()
        
        RootAssembly.coreAssembly.signUpRequestSender.send(
            with: [
                "email":userData.email,
                "username":userData.userName,
                "password":userData.password
            ],
            
            config: signUpRequestConfigue) { (result: Result<SignUpResponse, NetworkError>) in
            
            switch result {
            case .success(let response):
                resultHandler(response, nil)
            case .failure(let error):
                resultHandler(nil, error)
            }
        }
    }
}
