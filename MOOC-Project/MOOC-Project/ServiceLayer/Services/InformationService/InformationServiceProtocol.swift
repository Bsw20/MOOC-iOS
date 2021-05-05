//
//  InformationServiceProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

protocol InformationServiceProtocol {
    func saveData(email: String, login: String)
    func getData() -> (email: String, login: String)?
}
