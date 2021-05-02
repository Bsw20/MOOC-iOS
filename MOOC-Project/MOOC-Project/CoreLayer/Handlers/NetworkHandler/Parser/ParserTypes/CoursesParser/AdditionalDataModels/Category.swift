//
//  Category.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

struct Category: Decodable {
    var id: Int?
    var name: CategoryName
}

struct CategoryName: Decodable {
    var ru: String?
    var en: String?
}
