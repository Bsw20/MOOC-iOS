//
//  CoursesParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

struct CoursesResponse: Decodable {
    var previousPage: String?
    var nextPage: String?
    var courses: [CourseResponseShortDataModel]
    var countPages: Int
}

class CoursesParser: IParser {
    func parse(data: Data) -> CoursesResponse? {
        do {
            return  try JSONDecoder().decode(CoursesResponse.self, from: data)
        } catch {
            Logger.logNetWork(description: "failed to load courses - courses parser", logType: .error)
        }
        return nil
    }
}
