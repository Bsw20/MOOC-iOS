//
//  CourseParsedDataModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 03.05.2021.
//

import Foundation

// general data model
struct GeneralParsedCourseDataModel {
    var isFavourite: Bool
    var isViewed: Bool
    var course: CourseParsedDataModel
}

struct GeneralParsedCoursesDataModel {
    var previousPage: String?
    var nextPage: String?
    var courses: [CourseParsedShortDataModel]
    var countPages: Int
}

struct CourseParsedShortDataModel: Identifiable {
    var courseLanguages: [String]
    var courseName: String
    var id: String
    var shortDescription: String
    var categories: [CourseParsedCategoryDataModel]
    var link: String
    var previewImageLink: String
    var rating: CourseParsedRatingsDataModel
    var vendor: CourseParsedVendorDataModel
    var author: CourseParsedAuthorDataModel
    var duration: String
    var price: CourseParsedPriceDataModel
}

struct CourseParsedDataModel {
    var courseLanguages: [String]
    var id: String
    var courseName: String
    var description: String
    var shortDescription: String
    var categories: [CourseParsedCategoryDataModel]
    var link: String
    var previewImageLink: String
    var rating: CourseParsedRatingsDataModel
    var countViews: Int
    var vendor: CourseParsedVendorDataModel
    var author: CourseParsedAuthorDataModel
    var duration: String
    var price: CourseParsedPriceDataModel
}

// category
struct CourseParsedCategoryDataModel {
    var id: Int
    var name: CourseParsedCateogryNameDataModel
}

struct CourseParsedCateogryNameDataModel {
    var ru: String
    var en: String
}

// ratings
struct CourseParsedRatingsDataModel {
    var external: CourseParsedRatingDataModel
    var inner: CourseParsedRatingDataModel
}

struct CourseParsedRatingDataModel {
    var averageScore: Double
    var countReviews: Int
}

// vendor
struct CourseParsedVendorDataModel {
    var id: String
    var name: String
    var link: String
    var icon: String
}

// author
struct CourseParsedAuthorDataModel {
    var name: String
    var link: String
    var icon: String
}

// price
struct CourseParsedPriceDataModel {
    var amount: Double
    var currency: String
}
