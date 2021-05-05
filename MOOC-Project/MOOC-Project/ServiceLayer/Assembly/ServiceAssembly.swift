//
//  ServiceAssembly.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 18.04.2021.
//

import Foundation

class ServiceAssembly: ServiceAssemblyProtocol {
    lazy var signValidation: SignValidationTextFieldsProtocol = SignValidationTextFields()
    lazy var keyChainStoreJWT: KeyChainWrapperProtocol = KeychainWrapper()
    lazy var jwtTokenHandler: JWTTokenHandlerProtocol = JWTTokenHandler()
    lazy var networkService: NetworkServiceProtocol = NetworkService()
    lazy var sessionService: SessionServiceProtocol = SessionService()
    lazy var informationService: InformationServiceProtocol = InformationService()
}
