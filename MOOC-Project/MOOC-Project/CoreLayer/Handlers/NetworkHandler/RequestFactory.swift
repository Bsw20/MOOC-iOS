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
                request: SignUpRequest(),
                parser: SignUpParser())
        }
    }
}
