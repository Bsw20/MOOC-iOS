//
//  AuthInputButtons.swift
//  MOOC
//
//  Created by Андрей Самаренко on 11.04.2021.
//

import SwiftUI

struct AuthInputButtons: View {
    var body: some View {
        AuthInLogInButton(
            text: "Log In",
            backColor: Color(.black))
            .padding(
                .init(top: 0,
                      leading: 0,
                      bottom: 0.1,
                      trailing: 0))
    }
}

struct AuthInputButtons_Previews: PreviewProvider {
    static var previews: some View {
        AuthInputButtons()
    }
}

struct AuthInLogInButton: View {
    var text : String
    var backColor : Color
    @State var logIn: Bool = false
    var body : some View{
        Button(action: {
            logIn = true
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
        .fullScreenCover(isPresented: $logIn, content: {
            
        })
    }
}
