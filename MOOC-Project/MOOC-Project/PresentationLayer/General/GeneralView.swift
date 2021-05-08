//
//  GeneralView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 08.05.2021.
//

import SwiftUI

struct GeneralView: View {
    @State var courses: [CourseParsedShortDataModel] = []
    @State var model: GeneralModel = GeneralModel()
    @State var data: MainInfoParsedDataModel
    @State var searchModel: SearchModel = SearchModel()
    @State var currentCategory: String = "Рекомендации"
    
    var body: some View {
        ScrollView {
        VStack {
            GeneralTopView(model: $model)
                .frame(maxWidth: .infinity)
                .padding()
            VStack(alignment: .leading) {
                Divider()
                Text("Подборки:")
                    .font(.title3)
                    .fontWeight(.heavy)
                Categories(currentCategory: $currentCategory,
                           model: $model,
                           data: $data,
                           courses: $courses)
                Divider()
                Text("\(currentCategory):")
                    .font(.title3)
                    .fontWeight(.heavy)
                VStack {
                    ForEach(courses) { cell in
                        NavigationLink(destination: Preview(model: $searchModel, id: cell.id)) {
                            SearchTableItemView(data: cell)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                        }
                    }
                }
            }.padding(.horizontal, 15)
        }
        }
    }
}

struct GeneralView_Previews: PreviewProvider {
    @State static var isLoading: Bool = false
    
    static var previews: some View {
        PreviewMainView(isLoading: $isLoading)
    }
}

struct GeneralTopView: View {
    @Binding var model: GeneralModel
    var body: some View {
        VStack {
            Text("MOOC")
                .fontWeight(.bold)
                .padding(.horizontal, 0)
                .padding(.vertical, 4)
            HStack {
                VStack(alignment: .leading) {
                    Text("Добро пожаловать, \(model.getUserInformation().login)!")
                        .foregroundColor(.black)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10)
                    Text("Давайте посмотрим, что мы сможем найти для вас сегодня")
                        .font(.callout)
                        .fontWeight(.light)
                        .foregroundColor(Color("headerTextColor"))
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}

struct PreviewMainView: View {
    @Binding var isLoading: Bool
    
    @State var gmodel: GeneralModel = GeneralModel()
    @State var model: SearchModel = SearchModel()
    @State private var result:Result<MainInfoParsedDataModel, NetworkError>?
    
    var body: some View {
        switch result {
        case .success (let innerResult):
            GeneralView(courses: innerResult.courses,
                        model: gmodel,
                        data: innerResult)
        case .failure(let error):
            Text(error.localizedDescription)
        default:
            ProgressView()
                .onAppear(perform: {
                    isLoading.toggle()
                    load()
                })
        }
    }
    
    private func load() {
        gmodel.getMainInfo { result in
            isLoading.toggle()
            self.result = result
        }
    }
}

struct Categories: View {
    @Binding var currentCategory: String
    @Binding var model: GeneralModel
    @Binding var data: MainInfoParsedDataModel
    @Binding var courses: [CourseParsedShortDataModel]
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button(action: {
                    
                    model.getMainInfo{ result in
                        switch result {
                        case .success(let response):
                            self.courses = response.courses
                            self.currentCategory = "Рекомендации"
                        default:
                            self.courses = []
                        }
                    }
                },
                label: {
                    VStack {
                        Image("logo")
                            .resizable()
                            .clipShape(Circle())
                            .centerCropped()
                            .frame(width: 70, height: 70, alignment: .center)
                            .padding(.all, 5)
                            .background(Circle()
                                            .stroke(
                                                currentCategory == "Рекомендации" ? Color.green : Color.gray, lineWidth: 2))
                            .padding(.all, 5)
                        Text("Рекомендации")
                            .font(.subheadline)
                            .bold()
                    }
                })
                
                ForEach(data.compilations) { compilation in
                    Button(action: {
                        
                        RootAssembly.serviceAssembly.networkService.getCourses(arguments: ["url": compilation.link]) {  model, _ in
                            if let model = model {
                                self.courses = model.courses
                                self.currentCategory = compilation.name.ru
                            }
                        }
                    },
                    label: {
                        VStack {
                            RemoteImage(url: compilation.icon)
                                .clipShape(Circle())
                                .centerCropped()
                                .frame(width: 70, height: 70, alignment: .center)
                                .padding(.all, 5)
                                .background(Circle()
                                                .stroke(
                                                    currentCategory == compilation.name.ru ? Color.green: Color.gray, lineWidth: 2))
                                .padding(.all, 5)
                            Text(compilation.name.ru)
                                .font(.subheadline)
                                .bold()
                        }
                    })
                }
            }
        }
    }
}
