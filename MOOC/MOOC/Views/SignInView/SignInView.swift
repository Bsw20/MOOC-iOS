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
            SignInMiddleView()
            SignInBottomView()
        }
    }
}
#if DEBUG
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
#endif

struct SignInTopView : View {
    var body : some View {
        VStack {
            Text("MOOC")
                .fontWeight(.bold)
                .padding(.init(top: 0,
                               leading: 0,
                               bottom: 4,
                               trailing: 0))
            SignInBigBoldTextView(text: "Welcome to\nMOOC!")
        }
    }
}

struct SignInMiddleView: View {
    var body: some View {
        SignInContentView()
    }
}

struct SignInBottomView: View {
    var body: some View {
        VStack{
            SignInRoundedRectButton(
                text: "Create account",
                backColor: Color(.black))
                .padding(
                    .init(top: 0,
                          leading: 0,
                          bottom: 0.1,
                          trailing: 0)
                )
            SignInUnderLinedTextButton(text: "I already have an account")
        }.padding(.bottom)
    }
}
