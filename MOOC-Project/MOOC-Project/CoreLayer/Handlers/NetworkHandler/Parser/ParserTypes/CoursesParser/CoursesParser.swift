//
//  CoursesParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

struct CoursesResponse: Decodable {
    var previousPage: String?
    var nextPage: String?
    var courses: [CourseResponseShortDataModel]
    var countPages: Int?
}

class CoursesParser: IParser {
    func parse(data: Data) -> CoursesResponse? {
        do {
            return  try JSONDecoder().decode(CoursesResponse.self, from: data)
                    } catch DecodingError.dataCorrupted(let context) {
                        print(DecodingError.dataCorrupted(context))
                    } catch DecodingError.keyNotFound(let key, let context) {
                        print(DecodingError.keyNotFound(key, context))
                    } catch DecodingError.typeMismatch(let type, let context) {
                        print(DecodingError.typeMismatch(type, context))
                    } catch DecodingError.valueNotFound(let value, let context) {
                        print(DecodingError.valueNotFound(value, context))
                    } catch let error {
                        print(error)
                    }

        return nil
    }
}
