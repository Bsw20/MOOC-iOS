//
//  InformationService.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

class InformationService: InformationServiceProtocol {
    func saveData(email: String, login: String) {
        RootAssembly.coreAssembly.informationSaveHandler.setInformation(userEmail: email, userLogin: login)
    }
    func getData() -> (email: String, login: String)? {
        return RootAssembly.coreAssembly.informationSaveHandler.getInformation()
    }
}
