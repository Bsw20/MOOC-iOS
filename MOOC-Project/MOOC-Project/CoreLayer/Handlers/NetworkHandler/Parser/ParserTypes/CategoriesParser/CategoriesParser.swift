//
//  CategoriesParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//
//        } catch DecodingError.dataCorrupted(let context) {
//            print(DecodingError.dataCorrupted(context))
//        } catch DecodingError.keyNotFound(let key, let context) {
//            print(DecodingError.keyNotFound(key,context))
//        } catch DecodingError.typeMismatch(let type, let context) {
//            print(DecodingError.typeMismatch(type,context))
//        } catch DecodingError.valueNotFound(let value, let context) {
//            print(DecodingError.valueNotFound(value,context))
//        } catch let error{
//            print(error)
//        }

import Foundation

class CategoriesParser: IParser {
    func parse(data: Data) -> [CourseResponseCategoryDataModel]? {
        do {
            return  try JSONDecoder().decode([CourseResponseCategoryDataModel].self, from: data)
        } catch {
            Logger.logNetWork(description: "failed to load categories - categories parser", logType: .error)
        }
        return nil
    }
}
