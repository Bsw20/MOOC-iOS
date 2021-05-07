//
//  SignUpParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 24.04.2021.
//

import Foundation

struct SignUpResponse: Decodable {
    let status: String?
    let error: String?
}

class SignUpParser: IParser {
    func parse(data: Data) -> SignUpResponse? {
        do {
            return  try JSONDecoder().decode(SignUpResponse.self, from: data)
        } catch {
            Logger.logNetWork(description: "FAILED TO PARSE SIGN UP RESPONSE: \n\(error.localizedDescription)",
                              logType: .error)
            return nil
        }
    }
}
