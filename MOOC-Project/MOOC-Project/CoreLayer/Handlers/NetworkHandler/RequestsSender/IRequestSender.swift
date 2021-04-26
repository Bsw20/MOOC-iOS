//
//  IRequestsSender.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 24.04.2021.
//

import Foundation

protocol IRequestSender {
    
    /*The main function to send request to the server and get response*/
    func send<Parser>(
        with body: [String: String]?,
        config: RequestConfig<Parser>,
        completonHandler: @escaping (Result<Parser.Response, NetworkError>) -> Void)
    where Parser: IParser
}
