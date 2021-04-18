//
//  AuthChoosingButtons.swift
//  MOOC
//
//  Created by Андрей Самаренко on 05.04.2021.
//

import SwiftUI

#if DEBUG
struct AuthChoosingButtons: View {
    var body: some View {
        VStack{
            AuthChoosingRoundedRectButton(
                text: "Continue with email",
                image: Image("mailIcon"),
                backColor: Color("continueWithEmailColor"), action: {}
            )
        }
    }
}

struct AuthChoosingButtons_Previews: PreviewProvider {
    static var previews: some View {
        AuthChoosingButtons()
    }
}
#endif

struct AuthChoosingRoundedRectButton: View{
    var text: String
    var image: Image
    var backColor: Color
    var action: (()->Void)
    var body: some View {
        
        Button(action: {
            action()
        })
        {
            HStack{
                image
                    .padding(
                        .init(
                            top: 10,
                            leading: 10,
                            bottom: 10,
                            trailing: 10)
                    )
                Text(text)
                    .fontWeight(.bold)
                    .font(.callout)
                    .foregroundColor(.white)
                    .frame(
                        minWidth: 210, maxWidth:  240,
                        minHeight: 38, maxHeight: 50,
                        alignment: .leading
                    )
                    .padding(
                        .init(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 0)
                    )
                
            }.background(
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
            .padding(
                .init(top: 0,
                      leading: 15,
                      bottom: 0,
                      trailing: 15)
            )
        }
    }
}

