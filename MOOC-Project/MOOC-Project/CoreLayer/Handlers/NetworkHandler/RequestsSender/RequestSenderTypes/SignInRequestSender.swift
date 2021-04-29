//
//  RequestSender.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 24.04.2021.
//

import Foundation

class SignInRequestSender: IRequestSender {
    
    let session: URLSession
    
    init(with session: URLSession) {
        self.session = session
    }
    
    func send<Parser>(
        with body: [String: String]?,
        config: RequestConfig<Parser>,
        completonHandler: @escaping (Result<Parser.Response, NetworkError>) -> Void)
    
    where Parser: IParser {
        
        /*URL validation*/
        guard let urlRequest = config.request.getUrlRequest(
                bodyArguments: body)
        else {
            completonHandler(.failure(.badUrl(message: "INCORRECT URL - SIGN IN")))
            return
        }
        
        /*Sending the request*/
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error) in
            
            if let error = error {
                completonHandler(.failure(.badSession(message: error.localizedDescription)))
                return
            }
            
            print(String(decoding: data ?? Data(), as: UTF8.self))
            
            // parsing response data
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
                    Logger.logNetWork(description: "RESPONSE-CODE: 200 LOG IN SUCCESSFULLY", logType: .success)
                    completonHandler(.success(parsedModel))
                    
                case 401:
                    Logger.logNetWork(description: "RESPONSE-CODE: 401 NO USER WITH THIS DATA", logType: .error)
                    completonHandler(.failure(.badCode(code: 401)))
                    
                default:
                    Logger.logNetWork(description: "UNDEFINED BEHAVIOR - SIGN IN RESPONSE", logType: .error)
                    completonHandler(.failure(.unknownError(message: "UNKNOWN ERROR CODE")))
                }
            }
        }
        task.resume()
    }
}
