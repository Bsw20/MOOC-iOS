//
//  SearchMainView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 29.04.2021.
//

import SwiftUI

struct SearchMainView: View {
    
    @Binding var showBottomBar: Bool
    @State var isSearchBarHidden = false
    @State var showCategories = false
    
    @State var searchModel: SearchModel = SearchModel()
    @State var currentResponse: CoursesResponse?
    @State var categories: [TouchableChip] = []
    @State var cells: [CourseParsedShortDataModel] = []
    @State var currentQuery: SearchQueryDataModel?
    
    var body: some View {
        VStack(spacing: 10) {
            if !isSearchBarHidden {
                SearchTextField(
                    labelText: "Find something new...",
                    icon: Image(systemName: "magnifyingglass"),
                    categoriesIcon: Image(systemName: "slider.horizontal.3"),
                    search: { search, categories, page, pageSize in
                        searchModel.searchRequest(with: search,
                                                  categories: categories,
                                                  pageNumber: page,
                                                  pageSize: pageSize) { response, _ in
                            
                            guard let response = response else {
                                return
                            }
                            
                            DispatchQueue.main.sync {
                                self.cells = response.courses
                                self.currentQuery = SearchQueryDataModel(
                                    currentPage: page,
                                    categories: categories,
                                    strQuery: search,
                                    maxPage: response.countPages,
                                    pageSize: pageSize)
                            }
                        }
                    },
                    barIsHidden: $showBottomBar, categories: $categories,
                    model: $searchModel,
                    showCategories: $showCategories)
                    .padding(.top, 5)
            }
            ScrollView(.vertical, showsIndicators: false) {
                
                if showCategories {
                    ChipsInnerContent(categories: $categories)
                        .padding(.top, 5)
                        .padding(.horizontal, 5)
                }
                
                GeometryReader { reader -> AnyView in
                    
                    let yAxis = reader.frame(in: .global).minY
                    
                    if yAxis < 0 && !isSearchBarHidden {
                        withAnimation {
                            DispatchQueue.main.async {
                                isSearchBarHidden = true
                                showBottomBar = false
                            }
                        }
                    } else if yAxis > 0 && isSearchBarHidden {
                        withAnimation {
                            DispatchQueue.main.async {
                                isSearchBarHidden = false
                                showBottomBar = true
                            }
                        }
                    }
                    return AnyView(Text("")
                                    .frame(width: 0, height: 0))
                }
                
                withAnimation {
                    ForEach(cells) { cell in
                        NavigationLink(destination: Preview(model: $searchModel, id: cell.id)) {
                            SearchTableItemView(data: cell)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                        }
                    }
                }
                
                if let currentQuery = currentQuery,
                   currentQuery.currentPage + 1 <= currentQuery.maxPage {
                    SearchRoundedRectButton(text: "load more", action: {
                        searchModel.searchRequest(
                            with: currentQuery.strQuery,
                            categories: currentQuery.categories,
                            pageNumber: currentQuery.currentPage + 1,
                            pageSize: currentQuery.pageSize, resultHandler: { response, _ in
                                guard let response = response else {
                                    return
                                }
                                DispatchQueue.main.sync {
                                    self.currentQuery?.currentPage += 1
                                    self.cells.append(contentsOf: response.courses)
                                }
                            })
                    })
                    .padding(.bottom, 10)
                    .padding(.top, 15)
                }
            }
            .frame(maxHeight: .infinity)
        }
        .navigationBarHidden(true)
    }
}

struct SearchMainView_Previews: PreviewProvider {
    @State static var showBottomBar = true
    static var previews: some View {
        SearchMainView(showBottomBar: $showBottomBar)
    }
}
