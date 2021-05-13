//
//  GeneralModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 08.05.2021.
//

import Foundation

class GeneralModel {
    
    func getUserInformation() -> (email: String, login: String) {
        if let info = RootAssembly.serviceAssembly.informationService.getData() {
            return info
        } else {
            return (email: "Unknown email", login: "Unknown login")
        }
    }
    
    func getMainInfo(resultHandler: @escaping (Result<MainInfoParsedDataModel, NetworkError>) -> Void) {
        RootAssembly.serviceAssembly.networkService.getMainInfo(resultHandler: resultHandler)
    }
}
