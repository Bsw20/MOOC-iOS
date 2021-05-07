//
//  NetworkService+Reviews.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

extension NetworkService {
    func getReviewsToCourse(courseId: String, resultHandler: @escaping(Result<CourseReviewsParsedDataModel?, NetworkError>) -> Void) {
        let reviewsConfigue = RequestFactory.ReviewsRequests.newGetReviewsForCourseConfigue()
        
        RootAssembly.coreAssembly.reviewsRequestSender.send(with: ["content-type": "application/json"],
                                                            with: ["id": courseId],
                                                            config: reviewsConfigue) { response in
            switch response {
            case .success(let result):
                resultHandler(.success(self.parseReviews(from: result)))
            case .failure(let error):
                resultHandler(.failure(error))
            }
        }
    }
    
    func deleteReviewForCourse(reviewId: String, resultHandler: @escaping(NetworkError?) -> Void) {
        let deleteConfigue = RequestFactory.ReviewsRequests.newDeleteReview()
        
        RootAssembly.coreAssembly.reviewsInteractionRequestSender.send(
            with: ["content-type": "application/json",
                   "Authorization": "Bearer \(RootAssembly.serviceAssembly.jwtTokenHandler.getToken(tokenType: .accessToken) ?? "NONE")"],
            with: ["reviewId": reviewId],
            config: deleteConfigue) { result in
            switch result {
            case .success:
                resultHandler(nil)
            case .failure(let error):
                switch error {
                case .badCode(let code):
                    if code == 401 {
                        self.refreshToken(resultHandler: {
                            self.deleteReviewForCourse(reviewId: reviewId, resultHandler: resultHandler)
                        })
                    } else {
                        resultHandler(error)
                    }
                default:
                    resultHandler(error)
                }
            }
        }
    }
        func addReviewForCourse(id: String, rating: Double, text: String, resultHandler: @escaping(NetworkError?) -> Void) {
            let addConfigue = RequestFactory.ReviewsRequests.newAddReview()
            RootAssembly.coreAssembly.reviewsInteractionRequestSender.send(
                with: ["content-type": "application/json",
                       "Authorization": "Bearer \(RootAssembly.serviceAssembly.jwtTokenHandler.getToken(tokenType: .accessToken) ?? "NONE")"],
                with: ["id": id,
                    "rating": String(rating),
                       "text": text],
                config: addConfigue) { result in
                switch  result {
                case .success:
                    resultHandler(nil)
                case .failure(let error):
                    switch error {
                    case .badCode(let code):
                        if code == 401 {
                            self.refreshToken(resultHandler: {
                                self.addReviewForCourse(id: id, rating: rating, text: text, resultHandler: resultHandler)
                            })
                        } else {
                            resultHandler(error)
                        }
                    default:
                        resultHandler(error)
                    }
                }
            }
        }
        
    private func parseReviews(from response: ReviewsResponse?) -> CourseReviewsParsedDataModel? {
        guard let response = response else {
            return nil
        }
        
        guard let courseId = response.courseId,
              let reviews = response.reviews else {
            return nil
        }
        
        var innerReviews: [CourseReviewParsedDataModel] = []
        
        for review in reviews {
            guard let rating = review.rating,
                  let text = review.text,
                  let creationDate = getDate(strFormat: review.creationDate),
                  let user = review.user,
                  let userName = user.username,
                  let id = review.id else { continue }
            innerReviews.append(.init(rating: rating,
                                      text: text,
                                      creationDate: creationDate,
                                      user: .init(userName: userName), id: id))
        }
        
        return .init(courseId: courseId, reviews: innerReviews)
    }
    
    func getDate(strFormat: String?) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter.date(from: strFormat ?? "")
    }
}
