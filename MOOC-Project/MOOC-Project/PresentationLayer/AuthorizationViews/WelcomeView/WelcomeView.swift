//
//  SignInView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 29.03.2021.
//

import SwiftUI

struct WelcomeView : View {
    var body : some View {
        VStack{
            WelcomeTopView()
            WelcomeMiddleView()
            WelcomeBottomView()
        }
    }
}
#if DEBUG
struct WelcomeView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView()
                .environment(\.sizeCategory, .extraLarge)
            WelcomeView()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
#endif

struct WelcomeTopView : View {
    var body : some View {
        VStack {
            Text("MOOC")
                .fontWeight(.bold)
                .padding(.init(top: 0,
                               leading: 0,
                               bottom: 4,
                               trailing: 0))
            WelcomeBigBoldTextView(text: "Welcome to\nMOOC!")
        }
    }
}

struct WelcomeMiddleView: View {
    var body: some View {
        WelcomeContentView()
    }
}

struct WelcomeBottomView: View {
    var body: some View {
        VStack{
            WelcomeRoundedRectButton(
                text: "Create account",
                backColor: Color(.black))
                .padding(
                    .init(top: 0,
                          leading: 0,
                          bottom: 0.1,
                          trailing: 0)
                )
            WelcomeUnderLinedTextButton(text: "I already have an account")
        }.padding(.bottom)
    }
}
