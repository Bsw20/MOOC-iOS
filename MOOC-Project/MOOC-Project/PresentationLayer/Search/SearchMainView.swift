//
//  SearchMainView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 29.04.2021.
//

import SwiftUI

struct SearchMainView: View {
    
    @State var isHide = false
    @State var searchModel: SearchModel = SearchModel()
    @State var currentResponse: CoursesResponse?
    @State var cells: [CourseParsedShortDataModel] = []
    @State var currentQuery: SearchQueryDataModel?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if !isHide {
                        SearchTextField(
                            labelText: "Find something new...",
                            icon: Image(systemName: "magnifyingglass"),
                            categoriesIcon: Image(systemName: "slider.horizontal.3"),
                            search: { search, categories, page, pageSize in
                                searchModel.searchRequest(with: search,
                                                          categories: categories,
                                                          pageNumber: page,
                                                          pageSize: pageSize) { response in
                                    
                                    guard let response = response else {
                                        return
                                    }
                                    
                                    DispatchQueue.main.sync {
                                        self.cells = self.searchModel.parseCourses(from: response)
                                        self.currentQuery = SearchQueryDataModel(
                                            currentPage: page,
                                            categories: categories,
                                            strQuery: search,
                                            maxPage: response.countPages,
                                            pageSize: pageSize)
                                    }
                                }
                            },
                            model: $searchModel)
                            .padding(.top, 5)
                    }
                    
                    GeometryReader { reader -> AnyView in
                        
                        let yAxis = reader.frame(in: .global).minY
                        
                        if yAxis < 0 && !isHide {
                            withAnimation {
                                DispatchQueue.main.async {
                                    isHide = true
                                }
                            }
                        } else if yAxis > 0 && isHide {
                            withAnimation {
                                DispatchQueue.main.async {
                                    isHide = false
                                }
                            }
                        }
                        
                        return AnyView(Text("")
                                        .frame(width: 0, height: 0))
                    }
                    
                    withAnimation {
                        ForEach(cells) { cell in
                            NavigationLink(destination: Preview(model: searchModel, id: cell.id)) {
                                SearchTableItemView(data: cell)}
                        }
                    }
                    if let currentQuery = currentQuery,
                       currentQuery.currentPage + 1 <= currentQuery.maxPage {
                        SearchRoundedRectButton(text: "load more", action: {
                            searchModel.searchRequest(
                                with: currentQuery.strQuery,
                                categories: currentQuery.categories,
                                pageNumber: currentQuery.currentPage + 1,
                                pageSize: currentQuery.pageSize, resultHandler: { response in
                                    guard let response = response else {
                                        return
                                    }
                                    DispatchQueue.main.sync {
                                        self.currentQuery?.currentPage += 1
                                        self.cells.append(contentsOf: searchModel.parseCourses(from: response))
                                    }
                                })
                        })
                        .padding(.bottom, 10)
                        .padding(.top, 15)
                    }
                }
            }
            .navigationBarHidden(true)
            
        }
    }
}

struct SearchMainView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMainView()
    }
}
