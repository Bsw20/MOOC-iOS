//
//  ParserProtocol.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 23.04.2021.
//

import Foundation

protocol IParser {    
    associatedtype Response
    func parse(data: Data) -> Response?
}
