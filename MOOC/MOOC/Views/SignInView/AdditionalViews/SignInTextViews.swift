//
//  SignInTextViews.swift
//  MOOC
//
//  Created by Андрей Самаренко on 02.04.2021.
//

import SwiftUI
#if DEBUG
struct SignInTextViews: View {
    var body: some View {
        VStack{
            SignInBigBoldTextView(text: "Welcome to MOOC App!")
            SignInRoundedRectButton(text: "Create an account", backColor: Color(.black))
            SignInUnderLinedTextButton(text: "I already have an account!")
        }
    }
}

struct SignInTextViews_Previews: PreviewProvider {
    static var previews: some View {
        SignInTextViews()
    }
}
#endif

struct SignInBigBoldTextView : View {
    let text : String
    var body : some View{
        Text(text)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundColor(Color("headerTextColor"))
            .multilineTextAlignment(.center)
            .padding(
                .init(
                    top: -15,
                    leading: 15,
                    bottom: 1.5,
                    trailing: 15)
            )
    }
}

struct SignInSubTextView : View {
    let text : String
    var body : some View{
        Text(text)
            .font(.footnote)
            .fontWeight(.light)
            .foregroundColor(Color("headerTextColor"))
            .multilineTextAlignment(.center)
    }
}

struct SignInRoundedRectButton : View{
    var text : String
    var backColor : Color
    @State var showAuthView: Bool = false
    var body : some View{
        Button(action: {
            showAuthView = true
        }) {
            HStack{
                Text(text)
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(
                        minWidth: 210, maxWidth:  240,
                        minHeight: 38, maxHeight: 50,
                        alignment: .center
                    )
                    .padding(
                        .init(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 0)
                    )
                
            }
            .background(
                RoundedRectangle(cornerRadius: 13, style: .continuous)
                    .stroke(Color(.white), lineWidth: 1.5)
                    .background(
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill(backColor)
                    )
                
            )
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        .fullScreenCover(isPresented: $showAuthView, content: {
            AuthChoosing()
        })
    }
}

struct SignInUnderLinedTextButton : View {
    @State var showAuthInputView: Bool = false
    var text: String
    var body : some View {
        Button(action: {
            showAuthInputView = true
        }, label: {
            Text(text)
            .font(.caption)
            .fontWeight(.light)
            .underline()
            .multilineTextAlignment(.center)
        })
        .fullScreenCover(isPresented: $showAuthInputView, content: {
            AuthInputView()
        })
    }
}

