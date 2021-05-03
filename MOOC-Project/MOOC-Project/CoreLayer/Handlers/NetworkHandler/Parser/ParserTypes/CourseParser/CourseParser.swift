//
//  CourseParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 03.05.2021.
//

import Foundation

// general data model
struct GeneralCourseResponse: Decodable {
    var isFavourite: Bool?
    var isViewed: Bool?
    var course: CourseResponseDataModel?
    var error: String?
}

class CourseParser: IParser {
    func parse(data: Data) -> GeneralCourseResponse? {
        do {
            print(String(decoding: data, as: UTF8.self))
            return  try JSONDecoder().decode(GeneralCourseResponse.self, from: data)
        } catch {
            return nil
        }
    }
}
