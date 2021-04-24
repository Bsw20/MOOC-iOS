//
//  RootAssemblyProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 18.04.2021.
//

import Foundation

protocol RootAssemblyProtocol {
    static var serviceAssembly: ServiceAssemblyProtocol {get}
    static var coreAssembly: CoreLayerAssemblyProtocol {get}
}
