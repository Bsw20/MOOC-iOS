//
//  InformationSavingHandlerProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

protocol InformationSavingHandlerProtocol {
    func setInformation(userEmail: String, userLogin: String)
    func getInformation() -> (email: String, login: String)?
}
