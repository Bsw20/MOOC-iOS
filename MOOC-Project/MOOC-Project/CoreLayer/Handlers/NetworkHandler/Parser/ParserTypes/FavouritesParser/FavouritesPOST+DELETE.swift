//
//  FavouritesParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//
import Foundation

struct FavouriteInteractionResponse: Decodable {
    var favouriteCourses: [String]?
    var error: String?
}

class FavouriteResponseInteractionParser: IParser {
    func parse(data: Data) -> FavouriteInteractionResponse? {
        do {
            return  try JSONDecoder().decode(FavouriteInteractionResponse.self, from: data)
        } catch {
            Logger.logNetWork(description: "failed to load courses - Favourite Response interaction parser", logType: .error)
        }
        return nil
    }
}
