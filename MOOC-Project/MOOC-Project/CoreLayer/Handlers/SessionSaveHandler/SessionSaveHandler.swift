//
//  CurrentSessionHandler.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 27.04.2021.
//

import Foundation

class SessionSaveHandler: SessionSaveHandlerProtocol {
    private static let sessionKey = "CurrentSessionKey"
    func getCurrentSessionStatus() -> Bool {
        guard let storedValue =
                UserDefaults.standard.value(forKey: SessionSaveHandler.sessionKey) as? Bool
        else {
            setCurrentSessionStatus(status: false)
            return false
        }
        return storedValue
    }
    
    func setCurrentSessionStatus(status: Bool) {
        UserDefaults.standard.setValue(status, forKey: SessionSaveHandler.sessionKey)
        UserDefaults.standard.synchronize()
    }
}
