//
//  SessionService.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 27.04.2021.
//

import CoreData
import Foundation

class SessionService: SessionServiceProtocol {
    func getCurrentSessionValue () -> Bool {
        return RootAssembly.coreAssembly.sessionSaveHandler.getCurrentSessionStatus()
    }
    
    func setCurrentSessionValue(for observerName: String, value: Bool) {
        RootAssembly.coreAssembly.sessionSaveHandler.setCurrentSessionStatus(status: value)
        NotificationCenter.default.post(name: NSNotification.Name(observerName), object: nil)
    }
    
    func enableObserver(for observerName: String, handler: @escaping () -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(observerName), object: nil, queue: .main) { (_) in
            handler()
        }
    }
}
