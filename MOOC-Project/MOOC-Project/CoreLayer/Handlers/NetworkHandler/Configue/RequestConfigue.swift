//
//  RequestConfigue.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 25.04.2021.
//

import Foundation

/*Class for working with data and requests at the same time*/
struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
}
