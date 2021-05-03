//
//  ICoreLayer.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 23.04.2021.
//

import Foundation

protocol CoreLayerAssemblyProtocol {
    var signUpRequestSender: IRequestSender {get}
    var signInRequestSender: IRequestSender {get}
    var tokenRequestSender: IRequestSender {get}
    var logOutRequestSender: IRequestSender {get}
    var coursesRequestSender: IRequestSender {get}
    var categoriesRequestSender: IRequestSender {get}
    var courseRequestSender: IRequestSender {get}

    var sessionSaveHandler: SessionSaveHandlerProtocol {get}
}
