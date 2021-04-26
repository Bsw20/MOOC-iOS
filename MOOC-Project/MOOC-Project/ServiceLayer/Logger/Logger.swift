//
//  Logger.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 23.04.2021.
//

import Foundation

class Logger {
    
    enum LogType: String {
        case error
        case warning
        case success
    }
    
    private static let keyToLogJWTErrors = "-includeJWTLog"
    private static let keyToLogNetWork = "-includeNetWorkLog"
    
    static func logNetWork(description: String, logType: LogType) {
        if CommandLine.arguments.contains(Logger.keyToLogNetWork) {
            switch logType {
            case LogType.error:
                NSLog("📕 NETWORK ERROR: \(description)")
            case LogType.warning:
                NSLog("📙 NETWORK WARNING: \(description)")
            case LogType.success:
                NSLog("📗 NETWORK SUCCESS: \(description)")
            }
        }
    }
    
    static func logJWT(description: String, logType: LogType) {
        if CommandLine.arguments.contains(Logger.keyToLogJWTErrors) {
            switch logType {
            case LogType.error:
                NSLog("📕 JWT ERROR: \(description)")
            case LogType.warning:
                NSLog("📙 JWT WARNING: \(description)")
            case LogType.success:
                NSLog("📗 JWT SUCCESS: \(description)")
            }
        }
    }
}
