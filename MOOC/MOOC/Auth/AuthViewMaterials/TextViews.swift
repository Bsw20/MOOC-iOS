//
//  TextViews.swift
//  MOOC
//
//  Created by Андрей Самаренко on 02.04.2021.
//

import SwiftUI

struct AuthViewBigBoldText : View {
    let text : String
    var body : some View{
        Text(text)
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("headerTextColor"))
            .multilineTextAlignment(.leading)
            .padding(
                .init(
                    top: -15,
                    leading: 15,
                    bottom: 1.5,
                    trailing: 15)
            )
    }
}

struct AuthViewSubText : View {
    let text : String
    var body : some View{
        Text(text)
            .font(.caption)
            .fontWeight(.light)
            .foregroundColor(Color("headerTextColor"))
            .multilineTextAlignment(.leading)
    }
}

struct AuthViewRoundedRectButton : View{
    var text : String
    var image : Image
    var backColor : Color
    var action: (()->Void)
    var body : some View{
        Button(action: {
            action()
        })
        {
            HStack{
                image
                    .padding(
                        .init(
                            top: 10,
                            leading: 10,
                            bottom: 10,
                            trailing: 10)
                    )
                Text(text)
                    .fontWeight(.bold)
                    .font(.callout)
                    .foregroundColor(.white)
                    .frame(
                        minWidth: 210, maxWidth:  240,
                        minHeight: 38, maxHeight: 50,
                        alignment: .leading
                    )
                    .padding(
                        .init(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 0)
                    )
                
            }.background(
                RoundedRectangle(cornerRadius: 13, style: .continuous)
                    .stroke(Color(.white), lineWidth: 1.5)
                    .background(
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill(backColor)
                    )
                
            )
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        
        
    }
}
