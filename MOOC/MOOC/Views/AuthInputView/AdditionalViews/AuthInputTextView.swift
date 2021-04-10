//
//  AuthInputViewBoldTextView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 10.04.2021.
//

import SwiftUI

struct AuthInputTextView: View {
    var body: some View {
        VStack {
            AuthInputBigBoldTextView(text: "Welcome,")
            
            AuthInputBoldSubTextView(text: "Sign in to continue!")
            AuthInputDescriptionTextView(text: "We use JWT-tokens for authorization, so you don't have to worry about the safety of your data.")
            AuthInputUnderlinedTextView(text: "Register")
        }
    }
}

#if DEBUG
struct AuthInputTextView_Previews: PreviewProvider{
    static var previews: some View {
        AuthInputTextView()
            .environment(\.sizeCategory, .extraLarge)
        AuthInputTextView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
#endif

struct AuthInputBigBoldTextView : View {
    let text : String
    var body : some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundColor(Color("headerTextColor"))
            .multilineTextAlignment(.leading)
    }
}

struct AuthInputBoldSubTextView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color("authSubTextColor"))
            .multilineTextAlignment(.leading)
    }
}

struct AuthInputDescriptionTextView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.footnote)
            .foregroundColor(Color("headerTextColor"))
            .fontWeight(.light)
            .multilineTextAlignment(.leading)
    }
}

struct AuthInputUnderlinedTextView: View {
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
