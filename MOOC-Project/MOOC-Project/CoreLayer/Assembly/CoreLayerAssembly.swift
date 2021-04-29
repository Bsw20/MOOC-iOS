//
//  ICoreLayerAssembly.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 23.04.2021.
//

import Foundation

class CoreLayerAssembly: CoreLayerAssemblyProtocol {
    var signUpRequestSender: IRequestSender = SignUpReqestSender(with: .shared)
    var signInRequestSender: IRequestSender = SignInRequestSender(with: .shared)
    
    var sessionSaveHandler: SessionSaveHandlerProtocol = SessionSaveHandler()
}
