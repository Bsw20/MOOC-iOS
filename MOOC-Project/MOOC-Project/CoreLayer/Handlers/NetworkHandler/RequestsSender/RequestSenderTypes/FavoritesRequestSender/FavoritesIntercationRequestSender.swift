//
//  FavouritesRequestSender.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

class FavoritesIntercationRequestSender: IRequestSender {
    
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
            completonHandler(.failure(.badUrl(message: "INCORRECT URL - FAVOURITES interaction REQUEST")))
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
                    Logger.logNetWork(description: "RESPONSE-CODE: 200 course is deleted from favourites SUCCESSFULLY", logType: .success)
                    completonHandler(.success(parsedModel))
                case 401:
                    Logger.logNetWork(description: "response-code: 401 authorization required", logType: .error)
                    completonHandler(.failure(.badCode(code: 401)))
                case 201:
                    Logger.logNetWork(description: "response-code: 201 course is added to favourites", logType: .success)
                    completonHandler(.success(parsedModel))
                case 404:
                    Logger.logNetWork(description: "response-code: 404 course is not found", logType: .error)
                    completonHandler(.failure(.badCode(code: 404)))
                default:
                    Logger.logNetWork(description: "UNDEFINED BEHAVIOR - FAVOURITE COURSE RESPONSE \(response.statusCode)", logType: .error)
                    completonHandler(.failure(.unknownError(message: "UNKNOWN ERROR CODE")))
                }
            }
        }
        task.resume()
    }
}
