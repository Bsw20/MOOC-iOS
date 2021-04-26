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
}
