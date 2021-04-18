//
//  AuthInputButtons.swift
//  MOOC
//
//  Created by Андрей Самаренко on 11.04.2021.
//

import SwiftUI

struct SignButtons: View {
    var body: some View {
        VStack{
            SignButton(
                text: "Log In",
                backColor: Color(.black),
                isEnabled: false)
                .padding(
                    .init(top: 0,
                          leading: 0,
                          bottom: 0.1,
                          trailing: 0))
            SignAlternativeButton(
                icon: Image("appleIcon"),
                color: .black)
                .padding()
        }
    }
}

struct SignButtons_Previews: PreviewProvider {
    static var previews: some View {
        SignButtons()
    }
}

struct SignAlternativeButton: View {
    var icon: Image
    var color: Color
    var body: some View {
        Button(action: {
            
        })
        {
            ZStack{
                Circle()
                    .stroke(Color(.white),
                            lineWidth: 1.5)
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(
                        Circle()
                            .fill(color)
                    )
                icon
            }
        }
    }
}

struct SignButton: View {
    var text : String
    var backColor : Color
    var isEnabled: Bool
    
    var body : some View{
        Button(action: {
            
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
                            .fill(isEnabled ? backColor : Color.gray)
                    )
                
            )
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
    }
}