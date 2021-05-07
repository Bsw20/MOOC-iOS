//
//  SearchFullPage.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 02.05.2021.
//

import SwiftUI

struct Preview: View {
    @State var isAlertVisible: Bool = false
    @State var isLoading: Bool = false
    @State var isShowingReview: Bool = false
    
    @Binding var model: SearchModel
    var id: String
    @State private var result: Result<GeneralParsedCourseDataModel, NetworkError>?
    
    var body: some View {
        ZStack {
            switch result {
            case .success (let innerResult):
                SearchFullPage(isShowing: $isShowingReview,
                               model: $model,
                               refresh: {
                                self.result = nil
                               },
                               data: innerResult)
                        .zIndex(1)
                if isShowingReview {
                    CreateReviewAlertView(model: $model,
                                          isShowing: $isShowingReview,
                                          action: {
                                            self.result = nil
                                          },
                                          data: innerResult)
                        .zIndex(2)
                }
            default:
                HUDProgressView(placeHolder: "Please Wait",
                                show: $isLoading)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(2)
                    .onAppear(perform: {
                        isLoading.toggle()
                    loadCourse()
                })
            }
            
            if isLoading {
                HUDProgressView(placeHolder: "Please Wait",
                                show: $isLoading)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(2)
            }
        }
    }
    
    private func loadCourse() {
        model.receiveCourseDetails(id: id) { result in
            DispatchQueue.main.sync {
                self.result = result
                isLoading.toggle()
            }
           
        }
    }
}

struct SearchFullPage: View {
    
    @Binding var isShowing: Bool
    @State var isUpperHidden = false
    @Binding var model: SearchModel
    @Environment(\.presentationMode) var presentationMode

    var refresh: (() -> Void)
    var data: GeneralParsedCourseDataModel
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack {
            ScrollView {
            ZStack {
                VStack {
                    ZStack(alignment: .center) {
                        RemoteImage(url: data.course.previewImageLink)
                            .centerCropped()
                            .overlay(Color(.black).opacity(0.7))
                            .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                            .zIndex(0)
                            .ignoresSafeArea()
                        Text(data.course.courseName)
                            .fontWeight(.bold)
                            .lineLimit(3)
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 5)
                    }
                    
                    FullPageContentView(refresh: refresh, isShowing: $isShowing, model: $model,
                                        data: data)
                        .background(RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.white))
                        .offset(y: -30)
                }
               
            }
            .padding(.bottom, -5)
            .ignoresSafeArea(.all)
            }
            Button(action: {
                if let link = URL(string: data.course.link) {
                    openURL(link)
                }
                // добавить уведомление
            }, label: {
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
        }
        .navigationBarBackButtonHidden(false)
        .ignoresSafeArea(.all)
    }
}

struct CommentsList: View {
    var refresh: () -> Void
    @State var ownCommentIsShowing: Bool = true
    var data: GeneralParsedCourseDataModel
    @Binding var model: SearchModel
    
    @State private var commentsResult: Result<CourseReviewsParsedDataModel, NetworkError>?
    
    var body: some View {
        switch commentsResult {
        case .success (let result):
            if result.reviews.isEmpty {
                Text("No reviews yet")
            } else {
                VStack(alignment: .center) {
                    ForEach(result.reviews) { review in
                        CommentItem(model: $model,
                                    refresh: refresh,
                                    data: review,
                                    isEditable: model.checkReviewForOwnerShip(userName: review.user.userName))
                    }
                }
            }
            
        case .failure:
            Text("Failed to load comments")
        case nil:
            ProgressView().onAppear(perform: {
                loadComments()
            })
        }
    }
    
    func loadComments() {
        model.getReviewsForCourse(courseId: data.course.id) { result in
            self.commentsResult = result
        }
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
    @State static var model = SearchModel()
    static var data: GeneralParsedCourseDataModel =
        .init(isFavourite: true,
              isViewed: true,
              course: .init(courseLanguages: ["ru"],
                            id: "122",
                            courseName: "Экономика",
                            description: "Этот курс вводного уровня включает важнейшие и наиболее связанные с повседнrnv",
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
    @State static var isShowing: Bool = false
    static var previews: some View {
        SearchFullPage(
            isShowing: $isShowing, model: $model,
            refresh: {}, data: data)
    }
}

struct ContentChips: View {
    let titleKey: String
    var body: some View {
        HStack {
            Text(titleKey)
                .font(.title3)
                .fontWeight(.semibold)
                .lineLimit(1)
        }.padding(.all, 10)
        .foregroundColor(.gray)
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1.5)
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
        })
        .padding(.horizontal, 15)
        .padding(.vertical, 2)
    }
    
}

struct FullPageContentView: View {
    var refresh: (() -> Void)
    @Environment(\.openURL) var openURL
    @Binding var isShowing: Bool
    @Binding var model: SearchModel
    @State var data: GeneralParsedCourseDataModel
    var body: some View {
            VStack {
                VStack(spacing: 10) {
                    HStack {
                        CardHeadlineTextView(text: "Цена:")
                        CardContentTextView(
                            text: data.course.price.amount == 0
                                ? "Бесплатно"
                                : "\(data.course.price.amount) \(data.course.price.currency)")
                        Spacer()
                        Button(action: {
                            if data.isFavourite {
                                model.deleteFromFavourites(id: data.course.id) { error in
                                    if let error = error {
                                        print(error)
                                        return
                                    } else {
                                        data.isFavourite.toggle()
                                    }
                                }
                            } else {
                                model.addToFavourites(id: data.course.id) { error in
                                    if let error = error {
                                        print(error)
                                        return
                                    } else {
                                        data.isFavourite.toggle()
                                    }
                                }
                            }
                            
                        }, label: {
                            Image(systemName: data.isFavourite ? "heart.fill" : "heart")
                                .resizable()
                                .frame(minWidth: 25, maxWidth: 25,
                                       minHeight: 20, maxHeight: 20)
                                .foregroundColor(data.isFavourite ? Color(red: 52 / 255.0,
                                                                          green: 152 / 255.0,
                                                                          blue: 219 / 255.0) : .gray)
                                .aspectRatio(contentMode: .fit)
                            
                        })
                        Button(action: {
                            if data.isViewed {
                                model.deleteFromViewed(id: data.course.id) { error in
                                    if let error = error {
                                        print(error)
                                        return
                                    } else {
                                        data.isViewed.toggle()
                                    }
                                }
                            } else {
                                model.addToViewed(id: data.course.id) { error in
                                    if let error = error {
                                        print(error)
                                        return
                                    } else {
                                        data.isViewed.toggle()
                                    }
                                }
                            }
                        }, label: {
                            Image(systemName: data.isViewed ? "eye" : "eye.slash")
                                .resizable()
                                .frame(minWidth: 30, maxWidth: 30,
                                       minHeight: 20, maxHeight: 20)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(data.isViewed ? Color(red: 52 / 255.0,
                                                                       green: 152 / 255.0,
                                                                       blue: 219 / 255.0) : .gray)
                        })
                    }
                    .padding(.top, -5)
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
                }
                .frame(maxWidth: .infinity)
                Divider()
                VStack {
                    HStack {
                        CardHeadlineTextView(text: "Платформа")
                        Spacer()
                        CardHeadlineTextView(text: "Автор")
                    }
                    .padding(.bottom, 5)
                    HStack {
                        Button(action: { if let link = URL(string: data.course.vendor.link) {
                            openURL(link)
                        } }, label: {
                            HStack(alignment: .center) {
                                RemoteImage(url: data.course.vendor.icon)
                                    .centerCropped()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 20,
                                           maxHeight: 20)
                                
                                Text(data.course.vendor.name)
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                        })
                        Spacer()
                        Button(action: {
                            if let link = URL(string: data.course.author.link) {
                                openURL(link)
                            }
                        }, label: {
                            HStack {
                                RemoteImage(url: data.course.author.icon)
                                    .centerCropped()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 20,
                                           maxHeight: 20)
                                
                                Text(data.course.author.name)
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                        })
                    }
                }.padding(.horizontal, 15)
                Divider()
                VStack(alignment: .leading, spacing: 5) {
                    CardHeadlineTextView(text: "Рейтинг")
                        .padding(.bottom, 5)
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
                    }.padding(.bottom, 5)
                    
                    Text(data.course.description)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                }.padding(.horizontal, 15)
                Divider()
                VStack(alignment: .leading) {
                    HStack {
                        CardHeadlineTextView(text: "Комментрии:")
                        Button(action: {
                            withAnimation {
                                isShowing.toggle()
                            }
                        }, label: {
                            Image(systemName: "pencil.circle")
                                .resizable()
                                .frame(minWidth: 30, maxWidth: 30,
                                       minHeight: 30, maxHeight: 30)
                                .foregroundColor(.black)
                                .aspectRatio(contentMode: .fit)
                        })
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    CommentsList(refresh: refresh, data: data, model: $model)
                }
                .padding(.bottom, 10)
                .padding(.horizontal, 15)
            }
    }
}
