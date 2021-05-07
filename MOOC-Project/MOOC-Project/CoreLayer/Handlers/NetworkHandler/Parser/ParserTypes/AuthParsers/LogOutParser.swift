//
//  LogOutParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

struct LogOutResponse: Decodable {
    let status: String?
    let error: String?
}

class LogoutParser: IParser {
    func parse(data: Data) -> LogOutResponse? {
        do {
            return  try JSONDecoder().decode(LogOutResponse.self, from: data)
        } catch {
            Logger.logNetWork(description: "FAILED TO PARSE LOG OUT RESPONSE: \n\(error.localizedDescription)",
                              logType: .error)
            return nil
        }
    }
}
