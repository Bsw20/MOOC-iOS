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
    var tokenRequestSender: IRequestSender = TokenRequestSender(with: .shared)
    var logOutRequestSender: IRequestSender = LogOutRequestSender(with: .shared)
    var courseRequestSender: IRequestSender = CourseRequestSender(with: .shared)
    var categoriesRequestSender: IRequestSender = CategoriesRequestSender(with: .shared)
    
    var sessionSaveHandler: SessionSaveHandlerProtocol = SessionSaveHandler()
}
