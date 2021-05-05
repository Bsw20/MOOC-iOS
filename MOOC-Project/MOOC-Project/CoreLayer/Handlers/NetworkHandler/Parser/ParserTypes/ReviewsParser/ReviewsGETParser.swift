//
//  ReviewsGETParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

struct ReviewsResponse: Decodable {
    var courseId: String?
    var reviews: [ReviewResponse]?
}

struct ReviewResponse: Decodable {
    var rating: Double?
    var text: String?
    var creationDate: String?
    var user: UserReviewResponse?
    var id: String?
}

struct UserReviewResponse: Decodable {
    var username: String?
}

class ReviewsResponseParser: IParser {
    func parse(data: Data) -> ReviewsResponse? {
        do {
            return  try JSONDecoder().decode(ReviewsResponse.self, from: data)
        } catch {
            Logger.logNetWork(description: "failed to load courses - reviews Response parser", logType: .error)
        }
        return nil
    }
}
