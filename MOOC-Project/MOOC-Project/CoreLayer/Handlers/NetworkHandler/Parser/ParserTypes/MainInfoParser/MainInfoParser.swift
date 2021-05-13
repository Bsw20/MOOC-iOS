//
//  MainInfoParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 08.05.2021.
//

import Foundation

struct MainInfoResponse: Decodable {
    var compilations: [CompilationResponse]?
    var courses: [CourseResponseShortDataModel]?
}

struct CompilationResponse: Decodable {
    var name: CompilationName?
    var icon: String?
    var link: String?
}

struct CompilationName: Decodable {
    var ru: String?
    var en: String?
}

class MainInfoResponseParser: IParser {
    func parse(data: Data) -> MainInfoResponse? {
        do {
            return  try JSONDecoder().decode(MainInfoResponse.self, from: data)
        } catch {
            Logger.logNetWork(description: "failed to load courses - main info Response parser", logType: .error)
        }
        return nil
    }
}
