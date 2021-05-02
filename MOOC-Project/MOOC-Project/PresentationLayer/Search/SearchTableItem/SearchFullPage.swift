//
//  SearchFullPage.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 02.05.2021.
//

import SwiftUI

struct SearchFullPage: View {
    
    var body: some View {
        VStack {
            ScrollView {
                ZStack {
                    VStack {
                        ZStack(alignment: .center) {
                            Image("courseDefaultImage")
                                .resizable()
                                .overlay(Color(.black).opacity(0.7))
                                .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                                .zIndex(0)
                            Text("Методы и алгоритмы теории графов")
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
                                    CardContentTextView(text: "100$")
                                    Spacer()
                                    Image(systemName: "heart")
                                        .resizable()
                                        .frame(minWidth: 30,
                                               minHeight: 25)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.gray)
                                    Image(systemName: "eye.slash")
                                        .resizable()
                                        .frame(minWidth: 40,
                                               minHeight: 25)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.gray)
                                }
                                HStack {
                                    CardHeadlineTextView(text: "Язык:")
                                    CardContentTextView(text: "RU")
                                    Spacer()
                                }
                                VStack(alignment: .leading){
                                    HStack {
                                        CardHeadlineTextView(text: "Категории:")
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.top, 20)
                            .padding(.horizontal, 15)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                ContentChipsContent(chips: [.init(titleKey: "Гуманитарные науки"), .init(titleKey: "Тактическая типография")])
                                    .frame(maxHeight: .infinity)
                            }
                            .padding(.top, -10)
                            .frame(maxWidth: .infinity)
                            Divider()
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    CardHeadlineTextView(text: "Платформа")
                                    
                                    HStack(alignment: .center) {
                                        Image("companyIcon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 30,
                                                   maxHeight: 30)
                                        
                                        Text("OpenEdu")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                Spacer()
                                VStack (alignment: .trailing) {
                                    CardHeadlineTextView(text: "Автор")
                                    HStack {
                                        Image("companyIcon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 30,
                                                   maxHeight: 30)
                                        
                                        Text("OpenEdu")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                            }.padding(.horizontal, 15)
                            
                            Divider()
                            VStack(alignment: .leading, spacing: 5){
                                CardHeadlineTextView(text: "Рейтинг")
                                HStack {
                                    VStack(alignment: .leading) {
                                        RatingHeading(text: "Рейтинг openEdu: ")
                                        StarsView(rating: CGFloat(3), maxRating: 5)
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        RatingHeading(text: "Внутренний рейтинг: ")
                                        StarsView(rating: CGFloat(4.5), maxRating: 5)
                                    }
                                }
                            }.padding(.horizontal, 15)
                            Divider()
                            VStack(alignment: .leading) {
                                HStack {
                                    CardHeadlineTextView(text: "Описание:")
                                    Spacer()
                                }
                                
                                Text("some description "
                                + "jrnvejonvjoenvejvnjoenvnerovn")
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
            }.ignoresSafeArea(.all)
            Spacer()
            Group {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    ZStack {
                        Rectangle()
                         .fill(Color(red: 52/255.0,
                                     green: 152/255.0,
                                     blue: 219/255.0))
                         .frame(maxHeight: 55)
                            .zIndex(0)
                        Text("Перейти на страницу курса")
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                   
                })
            }
            .frame(alignment: .bottom)
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
    static var previews: some View {
        SearchFullPage()
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
