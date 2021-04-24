//
//  NetworkServiceProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 24.04.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func signInUser(userData: UserDataModel,
                    resultHandler: @escaping (SignUpResponse?, NetworkError?) -> Void)
}
