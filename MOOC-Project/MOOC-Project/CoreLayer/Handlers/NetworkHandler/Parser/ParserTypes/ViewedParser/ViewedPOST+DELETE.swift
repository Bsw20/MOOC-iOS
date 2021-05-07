//
//  ViewedParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

struct ViewedInteractionResponse: Decodable {
    var favouriteCourses: [String]?
    var error: String?
}

class ViewedResponseInteractionParser: IParser {
    func parse(data: Data) -> ViewedInteractionResponse? {
        do {
            return  try JSONDecoder().decode(ViewedInteractionResponse.self, from: data)
        } catch {
            Logger.logNetWork(description: "failed to load courses - Viewed Response interaction parser", logType: .error)
        }
        return nil
    }
}
