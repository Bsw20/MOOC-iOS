//
//  CourseResponse.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

struct Course: Decodable, Identifiable {
    let id: String
    let courseLanguages: [String]?
    let courseName: String?
    let description: String?
    let shortDescription: String?
    let categories: [Category]?
    let link: String?
    let previewImageLink: String?
    let rating: Ratings
    let vendor: Vendor
    let author: Author
    let duration: String?
    let price: Price
    let countViews: Int?
    let textScore: Double?
}
