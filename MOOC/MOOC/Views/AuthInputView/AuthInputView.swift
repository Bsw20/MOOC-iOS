//
//  AuthInputView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 10.04.2021.
//

import SwiftUI

struct AuthInputView: View {
    var body: some View {
        VStack{
            AuthInputTopView()
            AuthInputMiddleView()
            Spacer()
            AuthInputBottomView()
        }
    }
}

#if DEBUG
struct AuthInputView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthInputView()
                .environment(\.sizeCategory, .extraLarge)
            AuthInputView()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
#endif


struct AuthInputTopView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body : some View{
        ZStack{
            Text("MOOC")
                .fontWeight(.bold)
            
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                })
                {
                    Image(systemName: "chevron.backward")
                        .frame(maxWidth: 40,
                               maxHeight: 40)
                        .foregroundColor(Color("headerTextColor"))
                        .overlay(Circle()
                                    .strokeBorder(
                                        Color("headerTextColor"),
                                        lineWidth: 2)
                        )
                }
                
                Spacer()
            }
            .padding(
                .init(top: 0,
                      leading: 15,
                      bottom: 0,
                      trailing: 0
                )
            )
        }
    }
}

struct AuthInputMiddleView: View {
    var body: some View {
        VStack(alignment: .leading){
            AuthInputBigBoldTextView(text: "Welcome,")
            AuthInputBoldSubTextView(text: "Sign in to continue!")
                .padding(.bottom)
            AuthInputDescriptionTextView(text: "We use JWT-tokens for authorization, so you don't have to worry about the safety of your data.")
        }
        .padding(
            .init(
                top: 0,
                leading: 15,
                bottom: 0,
                trailing: 15
            )
        )
        VStack{
            AuthInputImageView(image: "DataImage")
                .padding(
                    .init(top: -15,
                          leading: -15,
                          bottom: -15,
                          trailing: -15)
                )
            
            AuthInputTextField(
                icon:Image("emailIconForTextField"), contentType: .emailAddress,
                labelText: "Email")
                .padding(
                    .init(top: 0,
                          leading: 0,
                          bottom: 5,
                          trailing: 0)
                )
            AuthInputTextField(icon: Image("passwordIconForTextField"), contentType: .password, labelText: "Password")
        }
        
    }
}

struct AuthInputImageView : View {
    let image: String
    var body : some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct AuthInputBottomView: View {
    var body: some View {
        VStack{
            AuthInLogInButton(text: "Log In",
                              backColor: Color(.black))
                .padding(
                    .init(top: 0,
                          leading: 0,
                          bottom: 0.1,
                          trailing: 0))
            AuthInputUnderlinedTextView(text: "Register")
        }
        .padding(.bottom)
    }
}
