//
//  ChipDataModel.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//
//
import SwiftUI

class ChipsDataModel: Identifiable, ObservableObject {
    let id = UUID()
    @State var isSelected: Bool = false
    let titleKey: String
    
    init(titleKey: String) {
        self.titleKey = titleKey
    }
}


struct ContentChipsDataModel: Identifiable{
    let id = UUID()
    let titleKey: String
}
