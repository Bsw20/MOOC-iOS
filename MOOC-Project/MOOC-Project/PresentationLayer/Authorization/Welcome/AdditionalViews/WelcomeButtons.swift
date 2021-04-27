//
//  WelcomeButtons.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 27.04.2021.
//

import SwiftUI

#if DEBUG
struct WelcomeButtons: View {
    @State var toShow: Bool = false
    var body: some View {
        VStack(spacing: 25) {
            WelcomeRoundedRectButton(showAuthView: $toShow,
                                     text: "Sign In",
                                     backColor: .black)
            WelcomeUnderLinedTextButton(text: "Sign Up",
                                        showAuthInputView: $toShow)
            
        }
    }
}

struct WelcomeButtons_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeButtons()
    }
}
#endif

struct WelcomeRoundedRectButton: View {
    // whether auth view is displayed or not
    @Binding var showAuthView: Bool
    
    // common values for button
    var text: String
    var backColor: Color
    
    var body : some View {
        Button(action: { showAuthView.toggle() }) {
            HStack {
                Text(text)
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(
                        minWidth: 210, maxWidth: 240,
                        minHeight: 38, maxHeight: 50,
                        alignment: .center
                    )
                    .padding(.all, 0)
            }
            .background(
                RoundedRectangle(cornerRadius: 13,
                                 style: .continuous)
                    .stroke(Color(.white),
                            lineWidth: 1.5)
                    .background(
                        RoundedRectangle(cornerRadius: 13,
                                         style: .continuous)
                            .fill(backColor)
                    )
                
            )
            .padding(.horizontal, 0)
            .padding(.vertical, 5)
        }
        .fullScreenCover(isPresented: $showAuthView,
                         content: { AuthChoosing() })
    }
}

struct WelcomeUnderLinedTextButton: View {
    // common text value to display for text view
    var text: String
    
    // whether auth input view is presented or not
    @Binding var showAuthInputView: Bool
    
    var body : some View {
        Button(action: { showAuthInputView.toggle() },
               label: {
                Text(text)
                    .font(.caption)
                    .fontWeight(.light)
                    .underline()
                    .multilineTextAlignment(.center)
               })
            .fullScreenCover(isPresented: $showAuthInputView, content: { SignInView() })
    }
}
