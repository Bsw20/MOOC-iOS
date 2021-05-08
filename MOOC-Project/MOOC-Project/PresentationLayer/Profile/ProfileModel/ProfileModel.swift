//
//  ProfileModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 07.05.2021.
//

import Foundation

class ProfileModel {
    func getUserInformation() -> (email: String, login: String) {
        if let info = RootAssembly.serviceAssembly.informationService.getData() {
            return info
        } else {
            return (email: "Unknown email", login: "Unknown login")
        }
    }
    
    func getFavoriteCourses(result: @escaping ([CourseParsedShortDataModel]?, NetworkError?) -> Void) {
        RootAssembly.serviceAssembly.networkService.getFavoritesCourses(resultHandler: result)
    }
    
    func getViewedCourses(result: @escaping ([CourseParsedShortDataModel]?, NetworkError?) -> Void) {
        RootAssembly.serviceAssembly.networkService.getViewedCourses(resultHandler: result)
    }
}
