//
//  RequestFactory.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 24.04.2021.
//

import Foundation

struct RequestFactory {
    struct AuthRequests {
        static func newSignUpConfigue() -> RequestConfig<SignUpParser> {
            return RequestConfig<SignUpParser>(
                request: SignRequest(type: .signUp),
                parser: SignUpParser())
        }
        
        static func newSignInCofigure() -> RequestConfig<SignInParser> {
            return RequestConfig<SignInParser>(
                request: SignRequest(type: .signIn),
                parser: SignInParser())
        }
    }
}
