//
//  SignInTextViews.swift
//  MOOC
//
//  Created by Андрей Самаренко on 02.04.2021.
//

import SwiftUI
#if DEBUG
struct WelcomeTextViews: View {
    var body: some View {
        VStack {
            WelcomeBigBoldTextView(text: "Welcome to MOOC App!")
        }
    }
}

struct WelcomeTextViews_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeTextViews()
    }
}
#endif

struct WelcomeBigBoldTextView: View {
    let text: String
    var body : some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundColor(Color("headerTextColor"))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 15)
            .padding(.top, -15)
            .padding(.bottom, 1.5)
    }
}

struct WelcomeSubTextView: View {
    let text: String
    var body : some View {
        Text(text)
            .font(.footnote)
            .fontWeight(.light)
            .foregroundColor(Color("headerTextColor"))
            .multilineTextAlignment(.center)
    }
}
