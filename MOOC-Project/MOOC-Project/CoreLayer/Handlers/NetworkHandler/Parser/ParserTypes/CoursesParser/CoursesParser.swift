//
//  CoursesParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

struct CoursesResponse: Decodable {
    var nextPage: String?
    var courses: [Course]
    var countPages: Int
}

class CoursesParser: IParser {
    func parse(data: Data) -> CoursesResponse? {
        do {
            return  try JSONDecoder().decode(CoursesResponse.self, from: data)
        } catch {
            Logger.logNetWork(description: "FAILED TO PARSE COURSE RESPONSE: \n\(error.localizedDescription)",
                              logType: .error)
            return nil
        }
    }
}
