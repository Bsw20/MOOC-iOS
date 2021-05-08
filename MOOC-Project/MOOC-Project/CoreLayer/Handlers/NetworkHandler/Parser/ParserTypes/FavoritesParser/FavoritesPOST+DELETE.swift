//
//  FavouritesParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//
import Foundation

struct FavoriteInteractionResponse: Decodable {
    var favouriteCourses: [String]?
    var error: String?
}

class FavoriteResponseInteractionParser: IParser {
    func parse(data: Data) -> FavoriteInteractionResponse? {
        do {
            return  try JSONDecoder().decode(FavoriteInteractionResponse.self, from: data)
        } catch {
            Logger.logNetWork(description: "failed to load courses - Favourite Response interaction parser", logType: .error)
        }
        return nil
    }
}
