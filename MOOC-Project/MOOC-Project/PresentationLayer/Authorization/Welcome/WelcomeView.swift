//
//  SignInView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 29.03.2021.
//

import SwiftUI

#if DEBUG
struct WelcomeViewPreview: PreviewProvider {
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

struct WelcomeView: View {
    
    @State var isAuthChoosingViewEnabled: Bool = false
    @State var isAuthInputViewEnabled: Bool = false
    
    var body : some View {
        VStack {
            WelcomeTopView()
            Spacer()
            WelcomeMiddleView()
            Spacer()
            Divider()
            WelcomeBottomView(isAuthChoosingViewEnabled: $isAuthChoosingViewEnabled,
                              isAuthInputViewEnabled: $isAuthInputViewEnabled)
        }
    }
}

struct WelcomeTopView: View {
    var body : some View {
        VStack {
            Text("MOOC")
                .fontWeight(.bold)
                .padding(.horizontal, 0)
                .padding(.vertical, 4)
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
    
    @Binding var isAuthChoosingViewEnabled: Bool
    @Binding var isAuthInputViewEnabled: Bool
    
    var body: some View {
        VStack {
            WelcomeRoundedRectButton(
                showAuthView: $isAuthChoosingViewEnabled,
                text: "Create account",
                backColor: Color(.black))
            WelcomeUnderLinedTextButton(text: "I already have an account",
                                        showAuthInputView: $isAuthInputViewEnabled)
        }.padding(.bottom)
    }
}
