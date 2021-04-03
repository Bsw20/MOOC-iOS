//
//  SignInView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 29.03.2021.
//

import SwiftUI

struct SignInView : View {
    var body : some View {
        VStack{
            SignInTopView()
                .padding(.init(top: 0,
                               leading: 0,
                               bottom: 4,
                               trailing: 0))
            SignInViewBigBoldText(text: "Welcome to\nMOOC!")
            ContentView()
            
            VStack{
                SignInViewRoundedRectTextView(
                    text: "Create account",
                    backColor: Color(.black))
                    .padding(
                        .init(top: 0,
                              leading: 0,
                              bottom: 0.1,
                              trailing: 0)
                    )
                SignInUnderLinedTextView(text: "I already have an account")
            }.padding(.bottom)
        }
    }
}

struct SignInView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            SignInView()
                .environment(\.sizeCategory, .extraLarge)
            SignInView()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
struct SignInTopView : View {
    var body : some View {
        Text("MOOC")
            .fontWeight(.bold)
    }
}
