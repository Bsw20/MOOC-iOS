//
//  SearchQuery.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 02.05.2021.
//

import Foundation

struct SearchQueryDataModel {
    var currentPage: Int
    var categories: [Int]
    var strQuery: String
    var maxPage: Int
    var pageSize: Int
}
