//
//  ServiceLayerProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 18.04.2021.
//

import Foundation

protocol ServiceAssemblyProtocol {
    var signValidation: SignValidationTextFieldsProtocol {get}
    var keyChainStoreJWT: KeyChainWrapperProtocol {get}
    var jwtTokenHandler: JWTTokenHandlerProtocol {get set}
    var networkService: NetworkServiceProtocol {get}
    var sessionService: SessionServiceProtocol {get}
}
