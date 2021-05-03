//
//  SearchFullPage.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 02.05.2021.
//

import SwiftUI

struct Preview: View {
    
    var model: SearchModel
    var id: String
    
    @State private var result: Result<GeneralParsedCourseDataModel, NetworkError>?
    
    var body: some View {
        switch result {
        case .success (let result):
            SearchFullPage(data: result)
        case .failure(let error):
            EmptyView()
        case nil:
            ProgressView().onAppear(perform: {
                loadCourse()
            })
        }
    }
    
    private func loadCourse() {
        RootAssembly.serviceAssembly.networkService.getCourse(id: id) { innerRes in
            switch innerRes {
            case .success(let response):
                guard let parsed = model.parseCourse(from: response) else { self.result = .failure(.badCode(code: 13))
                    return
                }
                result = .success(parsed)
            case .failure(let error):
                self.result = .failure(error)
            }
        }
    }
}


struct SearchFullPage: View {
    @State var data: GeneralParsedCourseDataModel
    var body: some View {
        VStack {
            ScrollView {
                ZStack {
                    VStack {
                        ZStack(alignment: .center) {
                            RemoteImage(url: data.course.previewImageLink)
                                .overlay(Color(.black).opacity(0.7))
                                .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                                .zIndex(0)
                            Text(data.course.courseName)
                                .fontWeight(.bold)
                                .lineLimit(3)
                                .font(.title2)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 5)
                                .zIndex(1)
                        } .ignoresSafeArea()
                        
                        Spacer()
                        
                        VStack {
                            VStack(spacing: 10) {
                                HStack {
                                    CardHeadlineTextView(text: "Цена:")
                                    CardContentTextView(text: "\(data.course.price.amount) \(data.course.price.currency)")
                                    Spacer()
                                    Image(systemName: "heart")
                                        .resizable()
                                        .frame(minWidth: 25, maxWidth: 25,
                                               minHeight: 20, maxHeight: 20)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.gray)
                                    Image(systemName: "eye.slash")
                                        .resizable()
                                        .frame(minWidth: 30, maxWidth: 30,
                                               minHeight: 20, maxHeight: 20)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.gray)
                                }
                                
                                HStack {
                                    CardHeadlineTextView(text: "Язык:")
                                    CardContentTextView(text: "\(data.course.courseLanguages.first ?? "unknown")")
                                    Spacer()
                                }
                                VStack(alignment: .leading) {
                                    HStack {
                                        CardHeadlineTextView(text: "Категории:")
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.top, 20)
                            .padding(.horizontal, 15)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                ContentChipsContent(chips: convertToChips(array: data.course.categories))
                                    .frame(maxHeight: .infinity)
                            }
                            .frame(maxWidth: .infinity)
                            Divider()
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    CardHeadlineTextView(text: "Платформа")
                                    
                                    HStack(alignment: .center) {
                                        RemoteImage(url: data.course.vendor.icon)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 20,
                                                   maxHeight: 20)
                                        
                                        Text(data.course.vendor.name)
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    CardHeadlineTextView(text: "Автор")
                                    HStack {
                                        RemoteImage(url: data.course.author.icon)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 20,
                                                   maxHeight: 20)
                                        
                                        Text(data.course.author.name)
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                            }.padding(.horizontal, 15)
                            
                            Divider()
                            VStack(alignment: .leading, spacing: 5) {
                                CardHeadlineTextView(text: "Рейтинг")
                                HStack {
                                    VStack(alignment: .leading) {
                                        RatingHeading(text: "Рейтинг \(data.course.vendor.name): ")
                                        StarsView(rating: CGFloat(data.course.rating.external.averageScore), maxRating: 5)
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        RatingHeading(text: "Внутренний рейтинг: ")
                                        StarsView(rating: CGFloat(data.course.rating.inner.averageScore), maxRating: 5)
                                    }
                                }
                            }.padding(.horizontal, 15)
                            Divider()
                            VStack(alignment: .leading) {
                                HStack {
                                    CardHeadlineTextView(text: "Описание:")
                                    Spacer()
                                }
                                
                                Text(data.course.description)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxHeight: .infinity)
                                
                            }.padding(.horizontal, 15)
                        }.background(RoundedRectangle(cornerRadius: 25.0)
                                        .fill(Color.white))
                        .padding(.top, -30)
                        
                    }
                    .zIndex(1)
                }
            }
            .padding(.bottom, -5)
            .ignoresSafeArea(.all)
            Button(action: {}, label: {
                ZStack {
                    Rectangle()
                        .fill(Color(red: 52 / 255.0,
                                    green: 152 / 255.0,
                                    blue: 219 / 255.0))
                        .frame(maxHeight: 55)
                        .zIndex(0)
                    Text("Перейти на страницу курса")
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(.white)
                        .zIndex(1)
                }
                
            })
        }.ignoresSafeArea(.all)
    }
}

struct CardHeadlineTextView: View {
    let text: String
    var body: some View {
        Text(text)
            .fontWeight(.medium)
            .font(.title2)
    }
}

struct CardContentTextView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.title2)
            .foregroundColor(Color(red: 102 / 255.0,
                                   green: 102 / 255.0,
                                   blue: 102 / 255.0))
            .fontWeight(.light)
    }
}

struct RatingHeading: View {
    let text: String
    var body: some View {
        Text(text)
            .fontWeight(.light)
            .font(.subheadline)
    }
}

struct SearchFullPage_Previews: PreviewProvider {
    
    static var data: GeneralParsedCourseDataModel =
        .init(isFavourite: false,
              isViewed: true,
              course: .init(courseLanguages: ["ru"],
                            id: "122",
                            courseName: "Экономика",
                            description: "Этот курс вводного уровня включает важнейшие и наиболее связанные с повседневной жи\n\n\njvnjr\n\n\nvjnrnv",
                            shortDescription: "jrnjrnvjrrnvnrjvnjnrvjnvjnvnjnjvsjvr",
                            categories: [.init(id: 1, name: .init(ru: "Наука", en: "Наука")), .init(id: 1, name: .init(ru: "Наука", en: "Наука"))],
                            link: "https://openedu.ru/course/hse/ECONOM",
                            previewImageLink: "https://cdn.openedu.ru/f1367c/CACHE/images/cover/logo-hs" +
                                "e-econom/3f82e83fd046c44136c727ae1f3a37cc.png",
                            rating: .init(external: .init(averageScore: 4, countReviews: 10), inner: .init(averageScore: 4.4, countReviews: 12)),
                            countViews: 15,
                            vendor: .init(id: "openedu", name: "OpenEdu", link: "https://openedu.ru/", icon: "https://api.mooc.ij.je/public_files/img/vendors/openedu.png"),
                            author: .init(name: "НИУ ВШЭ",
                                          link: "https://openedu.ru/university/hse/",
                                          icon: "https://cdn.openedu.ru/f1367c/university-icon/vse_vuIWGR2.png"),
                            duration: "10w",
                            price: .init(amount: 15000, currency: "RU")))
    
    static var previews: some View {
        SearchFullPage(data: data)
    }
}

struct ContentChips: View {
    let titleKey: String
    var body: some View {
        HStack {
            Text(titleKey)
                .font(.title3)
                .fontWeight(.light)
                .lineLimit(1)
        }.padding(.all, 10)
        .foregroundColor(.gray)
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 0.5)
        )
    }
}

func convertToChips(array: [CourseParsedCategoryDataModel]) -> [ContentChipsDataModel] {
    var chips: [ContentChipsDataModel] = []
    for category in array {
        chips.append(.init(titleKey: category.name.ru))
    }
    return chips
}

struct ContentChipsContent: View {
    @State var chips: [ContentChipsDataModel]
    
    var body: some View {
        HStack(content: {
            ForEach(chips) { chip in
                ContentChips(titleKey: chip.titleKey)
            }
        }).padding(.horizontal, 15)
    }
    
}
