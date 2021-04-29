//
//  SessionServiceProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 27.04.2021.
//

import Foundation

protocol SessionServiceProtocol {
    func getCurrentSessionValue () -> Bool
    func setCurrentSessionValue(for observerName: String, value: Bool)
    func enableObserver(for observerName: String, handler: @escaping () -> Void)
}
