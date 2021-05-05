//
//  CommentItem.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import SwiftUI

func getStrDate(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM y"
    return formatter.string(from: date)
}

struct CommentItem: View {
    var data: CourseReviewParsedDataModel
    @State var isEditable: Bool
    @State var showFull: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                StarsView(rating: CGFloat(data.rating), maxRating: 5)
                Spacer()
                Text(getStrDate(from: data.creationDate))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
            HStack {
                Text(data.user.userName)
                    .font(.title3)
                    .fontWeight(.medium)
                Spacer()
                if isEditable {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 30,
                               maxWidth: 30,
                               minHeight: 30,
                               maxHeight: 30)
                }
            }
            VStack(alignment: .leading, content: {
                if showFull {
                    Text(data.text)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                } else {
                    Text(data.text)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                }
               
            })
            .padding(.bottom, 10)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity, minHeight: 110)
        .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.gray, lineWidth: 0.5)
                        .shadow(radius: 5))
        .onTapGesture {
            withAnimation {
                showFull.toggle()
            }
        }
    }
}

struct CommentItem_Previews: PreviewProvider {
    static var data: CourseReviewParsedDataModel = .init(rating: 2.3,
                                                         text: "Очень плохо",
                                                         creationDate: Date(),
                                                         user: .init(userName: "TooManyQuestions"),
                                                         id: "rovntejov")
    static var previews: some View {
        CommentItem(data: data, isEditable: false)
    }
}
