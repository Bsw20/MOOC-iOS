//
//  ViewedGETParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 07.05.2021.
//

import Foundation

struct ViewedResponseComplicated: Decodable {
    var viewedCourses: [CourseResponseShortDataModel]?
    var error: String?
}

class ViewedResponseComplicatedParser: IParser {
    func parse(data: Data) -> ViewedResponseComplicated? {
        do {
            return  try JSONDecoder().decode(ViewedResponseComplicated.self, from: data)
        } catch {
            Logger.logNetWork(description: "failed to load courses - Viewed courses Response parser", logType: .error)
        }
        return nil
    }
}
