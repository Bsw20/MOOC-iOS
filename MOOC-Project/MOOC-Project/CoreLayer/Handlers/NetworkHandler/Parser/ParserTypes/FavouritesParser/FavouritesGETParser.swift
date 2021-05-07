//
//  FavouritesGETParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

// for GET request
struct FavouriteResponseComplicated: Decodable {
    var favouriteCourses: [CourseResponseShortDataModel]?
    var error: String?
}

class FavouriteResponseComplicatedParser: IParser {
    func parse(data: Data) -> FavouriteResponseComplicated? {
        do {
            return  try JSONDecoder().decode(FavouriteResponseComplicated.self, from: data)
        } catch {
            Logger.logNetWork(description: "failed to load courses - Favourite Response Complicated parser", logType: .error)
        }
        return nil
    }
}
