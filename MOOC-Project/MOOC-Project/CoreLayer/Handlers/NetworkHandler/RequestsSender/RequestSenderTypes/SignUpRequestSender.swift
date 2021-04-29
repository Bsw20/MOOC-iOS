//
//  SignInRequestSender.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 26.04.2021.
//

import Foundation

class SignUpReqestSender: IRequestSender {
    
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
            completonHandler(.failure(.badUrl(message: "INCORRECT URL - SIGN UP")))
            return
        }
        
        /*Sending the request*/
        let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error) in
            
            if let error = error {
                completonHandler(.failure(.badSession(message: error.localizedDescription)))
                return
            }
            
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
                    Logger.logNetWork(description: "RESPONSE-CODE: 200 CREATED SUCCESSFULLY", logType: .success)
                    completonHandler(.success(parsedModel))
                    
                case 400:
                    Logger.logNetWork(description: "RESPONSE-CODE: 400 ALREADY EXISTS", logType: .error)
                    completonHandler(.failure(.badCode(code: 400)))
                    
                case 500:
                    Logger.logNetWork(description: "RESPONSE-CODE: 500 INNER ERROR", logType: .error)
                    completonHandler(.failure(.badCode(code: 500)))
                    
                default:
                    Logger.logNetWork(description: "UNDEFINED BEHAVIOR - SIGN UP RESPONSE", logType: .error)
                    completonHandler(.failure(.unknownError(message: "Unknown error code")))
                }
            }
        }
        task.resume()
    }
}
