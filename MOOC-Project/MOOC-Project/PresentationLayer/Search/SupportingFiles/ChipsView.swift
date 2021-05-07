//
//  ChipsView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 02.05.2021.
//

import SwiftUI

struct ChipsInnerContent: View {
    @Binding var categories: [TouchableChip]
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: { for i in 0..<categories.count {
                categories[i].isSelected = false
            }}, label: {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .animation(.easeIn)
                    Text("Очистить фильтр").font(.title3).lineLimit(1)
                }
                .padding(.all, 10)
                .foregroundColor(Color.gray)
                .background(Color.white)
                .cornerRadius(40)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.gray, lineWidth: 1.5))
            })
            
            ForEach(0..<categories.count, id: \.self) {index in
                Button(action: { categories[index].isSelected.toggle() },
                       label: {
                    HStack {
                        if categories[index].isSelected {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .animation(.easeIn)
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(.gray)
                                .animation(.easeOut)
                        }
                        Text(categories[index].titleKey).font(.title3).lineLimit(1)
                    }.padding(.all, 10)
                    .foregroundColor(categories[index].isSelected ? Color.white : Color.gray)
                    .background(categories[index].isSelected ? Color.black : Color.white)
                    .cornerRadius(40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(categories[index].isSelected ? Color.black : Color.gray, lineWidth: 1.5))
                })
            }
        }
    }
}
