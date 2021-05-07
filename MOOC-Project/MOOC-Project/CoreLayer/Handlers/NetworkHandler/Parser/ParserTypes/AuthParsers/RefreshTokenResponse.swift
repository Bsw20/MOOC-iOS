//
//  RefreshTokenResponse.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

struct RefreshTokenResponse: Decodable {
    let accessToken: String?
    let refreshToken: String?
    let error: String?
}

class RefreshTokenParser: IParser {
    func parse(data: Data) -> RefreshTokenResponse? {
        do {
            return  try JSONDecoder().decode(RefreshTokenResponse.self, from: data)
        } catch {
            Logger.logNetWork(description: "FAILED TO REFRESH TOKEN RESPONSE: \n\(error.localizedDescription)",
                              logType: .error)
            return nil
        }
    }
}
