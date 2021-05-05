//
//  CourseReviewParsedDataModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

struct CourseReviewsParsedDataModel {
    var courseId: String
    var reviews: [CourseReviewParsedDataModel]
}

struct CourseReviewParsedDataModel: Identifiable {
    var rating: Double
    var text: String
    var creationDate: Date
    var user: CourseReviewUserParsedDataModel
    var id: String
}

struct CourseReviewUserParsedDataModel {
    var userName: String
}
