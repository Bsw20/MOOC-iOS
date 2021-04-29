//
//  AuthInputViewBoldTextView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 10.04.2021.
//

import SwiftUI

struct SignTextView: View {
    var body: some View {
        VStack {
            SignBigBoldTextView(text: "Welcome,")
            
            SignBoldSubTextView(text: "Sign in to continue!")
            SignDescriptionTextView(text: "We use JWT-tokens for authorization, so you don't have to worry about the safety of your data.")
            SignUnderlinedTextView(text: "Register")
        }
    }
}

#if DEBUG
struct SignTextView_Previews: PreviewProvider {
    static var previews: some View {
        SignTextView()
            .environment(\.sizeCategory, .extraLarge)
        SignTextView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
#endif

struct SignBigBoldTextView: View {
    let text: String
    var body : some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundColor(Color("headerTextColor"))
            .multilineTextAlignment(.leading)
    }
}

struct SignBoldSubTextView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color("authSubTextColor"))
            .multilineTextAlignment(.leading)
    }
}

struct SignDescriptionTextView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.footnote)
            .foregroundColor(Color("headerTextColor"))
            .fontWeight(.light)
            .multilineTextAlignment(.leading)
    }
}

struct SignUnderlinedTextView: View {
    let text: String
    var body : some View {
        Text(text)
            .font(.footnote)
            .fontWeight(.light)
            .foregroundColor(Color("headerTextColor"))
            .underline()
            .multilineTextAlignment(.center)
    }
}
