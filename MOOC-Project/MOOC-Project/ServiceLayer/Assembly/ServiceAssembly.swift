//
//  ServiceAssembly.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 18.04.2021.
//

import Foundation

class ServiceAssembly: ServiceAssemblyProtocol {
    var signValidation: SignValidationTextFieldsProtocol  = SignValidationTextFields()
    var keyChainStoreJWT: KeyChainWrapperProtocol = KeychainWrapper()
    var networkService: NetworkServiceProtocol = NetworkService()
}
