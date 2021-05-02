//
//  Rating.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

struct Ratings: Decodable {
    let external: Rating
    let inner: Rating
    
    private enum CodingKeys: String, CodingKey {
        case external
        case inner = "internal"
    }
}

struct Rating: Decodable {
    let averageScore: Double?
    let countReviews: Int?
}
