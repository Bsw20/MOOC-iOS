//
//  FavouritesGETParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

// for GET request
struct FavoriteResponseComplicated: Decodable {
    var favouriteCourses: [CourseResponseShortDataModel]?
    var error: String?
}

class FavoriteResponseComplicatedParser: IParser {
    func parse(data: Data) -> FavoriteResponseComplicated? {
        do {
            return  try JSONDecoder().decode(FavoriteResponseComplicated.self, from: data)
        } catch {
            Logger.logNetWork(description: "failed to load courses - Favorite courses Response parser", logType: .error)
        }
        return nil
    }
}
