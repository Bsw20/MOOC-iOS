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
    
    @State var textToFind: String = ""
    
    @Binding var barIsHidden: Bool
    @Binding var categories: [TouchableChip]
    @Binding var model: SearchModel
    @Binding var showCategories: Bool
    
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
                            search(textToFind, getCategories(categories: categories), 1, 5)
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
                            if categories.isEmpty {
                                model.receiveCategories { result in
                                    self.categories = result
                                }
                            }
                            showCategories.toggle()
                            barIsHidden = !showCategories
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
        }
    }
}

func getCategories(categories: [TouchableChip]) -> [Int] {

    let indexes = categories.enumerated().filter {
        $0.element.isSelected
        }.map { $0.offset }
    
    let result = indexes.isEmpty ? Array(0..<categories.count) : indexes
    return result
}

struct SearchTextFieldPreview: PreviewProvider {
    @State static var searchModel = SearchModel()
    @State static var categories: [TouchableChip] = []
    @State static var show: Bool = false
    @State static var barIsHidden = false
    static var previews: some View {
        VStack {
        SearchTextField(
            labelText: "Find something new...",
            icon: Image(systemName: "magnifyingglass"),
            categoriesIcon: Image(systemName: "slider.horizontal.3"),
            search: { search, categories, page, pageSize in
                searchModel.searchRequest(with: search,
                                          categories: categories,
                                          pageNumber: page,
                                          pageSize: pageSize) { response, _  in
                    
                    guard response != nil else {
                        return
                    }
                }
            },
            barIsHidden: $barIsHidden, categories: $categories,
                model: $searchModel,
            showCategories: $show)
            ChipsInnerContent(categories: $categories)
        }
    }
}
