//
//  ReviewsInteractionRequestSender.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 06.05.2021.
//

import Foundation

class ReviewsInteractionRequestSender: IRequestSender {
    
    let session: URLSession
    
    init(with session: URLSession) {
        self.session = session
    }
    
    func send<Parser>(
        with head: [String: String]?,
        with body: [String: String]?,
        config: RequestConfig<Parser>,
        completonHandler: @escaping (Result<Parser.Response, NetworkError>) -> Void)
    
    where Parser: IParser {
        
        /*URL validation*/
        guard let urlRequest = config.request.getUrlRequest(
                headArguments: head,
                bodyArguments: body)
        else {
            completonHandler(.failure(.badUrl(message: "INCORRECT URL - reviews interaction REQUEST")))
            return
        }
        
        /*Sending the request*/
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error) in
            
            if let error = error {
                completonHandler(.failure(.badSession(message: error.localizedDescription)))
                return
            }
            
            guard
                let data = data,
                let parsedModel: Parser.Response = config.parser.parse(data: data) else {
                
                if let error = error {
                    completonHandler(.failure(.badDataWhileParsing(message: error.localizedDescription)))
                }
                return
            }
            
            // receiving statusCode
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                
                case 200:
                    Logger.logNetWork(description: "response-code: 200 review deleted successfully", logType: .success)
                    completonHandler(.success(parsedModel))
                case 201:
                    Logger.logNetWork(description: "response-code: 201 review added successfully", logType: .success)
                    completonHandler(.success(parsedModel))
                case 400:
                    Logger.logNetWork(description: "response-code: 400 user has already given review to this course", logType: .error)
                    completonHandler(.failure(.badCode(code: 400)))
                case 401:
                    Logger.logNetWork(description: "response-code: 401 authorization required", logType: .error)
                    completonHandler(.failure(.badCode(code: 401)))
                default:
                    Logger.logNetWork(description: "UNDEFINED BEHAVIOR - COURSE REVIEWS interaction RESPONSE \(response.statusCode)", logType: .error)
                    completonHandler(.failure(.unknownError(message: "UNKNOWN ERROR CODE")))
                }
            }
        }
        task.resume()
    }
}
