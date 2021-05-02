//
//  SearchModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

class ChipsViewModel: ObservableObject {

    @Published var dataObject: [ChipsDataModel] = []

    func convertIntoCategories(from response: [Category]?) {
        guard let response = response else {
            return
        }
        for category in response {
            guard let name = category.name.ru else {continue}
            addChip(with: name)
        }
    }

    func addChip(with title: String) {
        dataObject.append(ChipsDataModel(titleKey: title))
    }
}

class SearchModel {
    public var categories: [Category]?
    
    func receiveCategories(result: @escaping([Category]?) -> Void) {
        if let categories = categories {
            result(categories)
        } else {
            RootAssembly.serviceAssembly.networkService.getActualCategories { response, _ in
                guard let response = response else {
                    result(nil)
                    return
                }
                result(response)
            }
        }
    }
    
    func parseCells(from response: CoursesResponse?) -> [SearchCellDataModel] {
        guard let response = response else {
            return []
        }
        var models: [SearchCellDataModel] = []
        
        for course in response.courses {
            guard
                let vendorName = course.vendor.name,
                let vendorIcon = course.vendor.icon,
                let courseName = course.courseName,
                let courseImage = course.previewImageLink,
                let shortDescription = course.shortDescription,
                let courseAverageScore = course.rating.external.averageScore,
                let courseCountReviews = course.rating.external.countReviews
            else {
                continue
            }
            models.append(.init(id: course.id,
                                vendorName: vendorName,
                                vendorIcon: vendorIcon,
                                courseName: courseName,
                                courseRating: courseAverageScore,
                                courseImage: courseImage,
                                price: course.price,
                                shortDescription: shortDescription,
                                countViews: courseCountReviews))
        }
        return models
    }
    
    func searchRequest(
        with stringQuery: String,
        categories: [Int],
        pageNumber: Int,
        pageSize: Int,
        resultHandler: @escaping(CoursesResponse?) -> Void) {
        
        RootAssembly.serviceAssembly.networkService.getCourses(
            arguments: ["pageSize": String(pageSize),
                        "pageNumber": String(pageNumber),
                        "searchQuery": stringQuery,
                        "categories": getCategories(categories: categories)]) { response, _ in
            
            guard let response = response else {
                resultHandler(nil)
                return
            }
            resultHandler(response)
        }
    }
    
    private func getCategories(categories: [Int]) -> String {
        let sortedCategories = categories.sorted()
        return sortedCategories.compactMap({ "\($0)"}).joined(separator: ",")
    }
}

