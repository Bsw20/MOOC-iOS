//
//  TokenSender.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

class TokenRequestSender: IRequestSender {
    
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
            completonHandler(.failure(.badUrl(message: "INCORRECT URL - TOKEN REFRESH")))
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
                    Logger.logNetWork(description: "RESPONSE-CODE: 200 TOKEN IS VALID", logType: .success)
                    completonHandler(.success(parsedModel))
                    
                case 401:
                    Logger.logNetWork(description: "RESPONSE-CODE: 400 TOKEN IS OUT OF TIME", logType: .error)
                    completonHandler(.failure(.badCode(code: 400)))
                    
                case 404:
                    Logger.logNetWork(description: "RESPONSE-CODE: 404 TOKEN IS NOT FOUND", logType: .error)
                    completonHandler(.failure(.badCode(code: 500)))
                    
                default:
                    Logger.logNetWork(description: "UNDEFINED BEHAVIOR - TOKEN REFRESH RESPONSE", logType: .error)
                    completonHandler(.failure(.unknownError(message: "Unknown error code")))
                }
            }
        }
        task.resume()
    }
}
