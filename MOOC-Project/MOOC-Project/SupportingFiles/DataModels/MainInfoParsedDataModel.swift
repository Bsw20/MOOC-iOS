//
//  MainInfoParsedDataModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 08.05.2021.
//

import Foundation

struct MainInfoParsedDataModel {
    var compilations: [CompilationParsedDataModel]
    var courses: [CourseParsedShortDataModel]
}

struct CompilationParsedDataModel: Identifiable {
    var id = UUID()
    var name: CompilationParsedName
    var icon: String
    var link: String
}

struct CompilationParsedName {
    var ru: String
    var en: String
}
