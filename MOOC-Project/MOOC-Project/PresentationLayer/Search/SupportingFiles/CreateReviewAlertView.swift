//
//  CreateReviewAlertView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 06.05.2021.
//

import SwiftUI
import StarRating

struct CreateReviewAlertView: View {
    @Binding var model: SearchModel
    @Binding var isShowing: Bool
    
    var action: () -> Void
    
    @State var rating: Double = 0
    @State var text: String = ""
    @State var customConfig =
        StarRatingConfiguration(
            numberOfStars: 5,
            stepType: .exact,
            borderWidth: 1,
            borderColor: .gray,
            emptyColor: .white,
            shadowRadius: 0,
            fillColors: [.yellow])
    
    var data: GeneralParsedCourseDataModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                HStack {
                    Text("Отзыв на курс")
                        .bold()
                        .font(.title)
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        model.addReview(id: data.course.id,
                                        rating: rating,
                                        text: text) { error in
                            if error != nil {
                                return
                            }
                            withAnimation {
                                isShowing.toggle()
                            }
                            action()
                        }
                    }, label: {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 50, maxHeight: 50)
                            .foregroundColor(Color.gray)
                    })
                }
                .disabled(text == "")
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                
                StarRating(initialRating: 0, configuration: $customConfig, onRatingChanged: {rating = $0})
                    .frame(maxHeight: 40)
                    .padding(.horizontal, 20)
                
                VStack {
                    TextEditor(text: $text)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)
                }.overlay(RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray, lineWidth: 1))
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: 300)
            .background(RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .shadow(radius: 10))
            .padding(.horizontal, 15)
            .zIndex(2)
            
            BlurView()
                .onTapGesture {
                    withAnimation {
                        isShowing.toggle()
                    }
                }
                .zIndex(0)
                .ignoresSafeArea(.all)
        }
        
    }
}

// struct CreateReviewAlertView_Previews: PreviewProvider {
//    @State static var model: SearchModel = SearchModel()
//    @State static var data: CourseReviewParsedDataModel =
//        CourseReviewParsedDataModel(rating: 0,
//                                    text: "",
//                                    creationDate: Date(),
//                                    user: .init(userName: "TooManyQuestions"), id: "some")
//    @State static var isShowing: Bool = true
//    static var previews: some View {
//        CreateReviewAlertView(model: $model,
//                              isShowing: $isShowing,
//                              data: $data)
//    }
// }
