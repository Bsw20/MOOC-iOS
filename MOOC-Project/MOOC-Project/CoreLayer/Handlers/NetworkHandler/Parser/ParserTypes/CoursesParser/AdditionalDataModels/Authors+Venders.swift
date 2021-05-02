//
//  Authors+Venders.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import Foundation

struct Vendor: Decodable {
    let id: String?
    let name: String?
    let icon: String?
}

struct Author: Decodable {
    let name: String?
    let link: String?
    let icon: String?
}
