//
//  ReviewsPOST+DELETEParser.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 06.05.2021.
//

import Foundation

struct ReviewsInteractionResponse: Decodable {
    var error: String?
}

class ReviewsIntercationResponseParser: IParser {
    func parse(data: Data) -> ReviewsInteractionResponse? {
        do {
            //            print(String(decoding: data, as: UTF8.self))
            return  try JSONDecoder().decode(ReviewsInteractionResponse.self, from: data)
        } catch DecodingError.dataCorrupted {
            return ReviewsInteractionResponse(error: nil)
        } catch {
            return nil
        }
    }
}
