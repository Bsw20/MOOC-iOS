//
//  SessionSaveHandlerProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 27.04.2021.
//

import Foundation

protocol SessionSaveHandlerProtocol {
    func getCurrentSessionStatus() -> Bool
    func setCurrentSessionStatus(status: Bool)
    
}
