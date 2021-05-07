//
//  DetailedCourseResponseDataModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 03.05.2021.
//

import Foundation

struct CourseResponseShortDataModel: Decodable {
    var courseLanguages: [String]
    var courseName: String?
    var id: String?
    var shortDescription: String?
    var categories: [CourseResponseCategoryDataModel]
    var link: String?
    var previewImageLink: String?
    var rating: CourseResponseRatingsDataModel
    var vendor: CourseResponseVendorDataModel
    var author: CourseResponseAuthorDataModel
    var duration: String?
    var price: CourseResponsePriceDataModel
}

struct CourseResponseDataModel: Decodable {
    var courseLanguages: [String]
    var id: String?
    var courseName: String?
    var description: String?
    var shortDescription: String?
    var categories: [CourseResponseCategoryDataModel]
    var link: String?
    var previewImageLink: String?
    var rating: CourseResponseRatingsDataModel
    var countViews: Int?
    var vendor: CourseResponseVendorDataModel
    var author: CourseResponseAuthorDataModel
    var duration: String?
    var price: CourseResponsePriceDataModel
}

// category
struct CourseResponseCategoryDataModel: Decodable {
    var id: Int?
    var name: CourseResponseCateogryNameDataModel
}

struct CourseResponseCateogryNameDataModel: Decodable {
    var ru: String?
    var en: String?
}

// ratings
struct CourseResponseRatingsDataModel: Codable {
    var external: CourseResponseRatingDataModel
    var inner: CourseResponseRatingDataModel
    
    enum CodingKeys: String, CodingKey {
        case external
        case inner = "internal"
    }
}

struct CourseResponseRatingDataModel: Codable {
    var averageScore: Double?
    var countReviews: Int?
}

// vendor
struct CourseResponseVendorDataModel: Decodable {
    var id: String?
    var name: String?
    var link: String?
    var icon: String?
}

// author
struct CourseResponseAuthorDataModel: Decodable {
    var name: String?
    var link: String?
    var icon: String?
}

// price
struct CourseResponsePriceDataModel: Decodable {
    var amount: Double?
    var currency: String?
}
