//
//  ChipDataModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//
//
import SwiftUI

struct ContentChipsDataModel: Identifiable {
    let id = UUID()
    let titleKey: String
}

struct TouchableChip: Identifiable {
    var id: Int
    var name: String
    @State var isTapped: Bool
}
