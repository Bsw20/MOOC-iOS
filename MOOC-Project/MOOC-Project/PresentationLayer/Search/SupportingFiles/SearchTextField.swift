//
//  SearchTextField.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 01.05.2021.
//

import SwiftUI

struct SearchTextField: View {
    var labelText: String
    var icon: Image
    var categoriesIcon: Image
    var search: ((String, [Int], Int, Int) -> Void)
            
    @Binding var model: SearchModel
    @State var textToFind: String = ""
    @State private var showCategories: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("MOOC")
                    .fontWeight(.bold)
                    .font(.title)
                Spacer()
                HStack {
                    Button(action: {
                        withAnimation {
                            search(textToFind, [1], 1, 5)
                        }
                    }, label: {
                        icon
                            .resizable()
                            .scaledToFit()
                            .frame(
                                minWidth: 20, maxWidth: 20,
                                minHeight: 40, maxHeight: 40
                            )
                            .foregroundColor(Color("textFieldColor"))
                            .padding(.horizontal, 10)
                        
                    })
                        TextField(labelText, text: $textToFind)
                            .font(Font.body.weight(.medium))
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .modifier(SignTextFieldClearButton(text: $textToFind))
                        
                        Button(action: {
                            withAnimation {
                                model.receiveCategories(result: { result in
                                    
                                })
                                showCategories.toggle()
                                
                            }
                        },
                        label: {
                            categoriesIcon
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    minWidth: 20, maxWidth: 20,
                                    minHeight: 40, maxHeight: 40
                                )
                                .foregroundColor(Color("textFieldColor"))
                                .padding(.horizontal, 10)
                        })
                }.background(
                    RoundedRectangle(cornerRadius: 20,
                                     style: .continuous)
                        .stroke(Color("textFieldColor"), lineWidth: 1.2)
                )
            }
            .padding(.horizontal, 12)
            
            if showCategories {
                    ScrollView {
                       
                    }
            }
        }
       
    }
}
