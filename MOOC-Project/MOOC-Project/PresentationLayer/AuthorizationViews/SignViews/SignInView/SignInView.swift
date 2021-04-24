//
//  AuthInputView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 10.04.2021.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack{
            AuthInputTopView()
            AuthInputMiddleView()
        }
    }
}

#if DEBUG
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignInView()
                .environment(\.sizeCategory, .extraLarge)
            SignInView()
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
            .padding(.leading, 15)
        }
    }
}

struct AuthInputMiddleView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                SignBigBoldTextView(text: "Welcome,")
                SignBoldSubTextView(text: "Sign in to continue!")
                    .padding(.bottom)
                SignDescriptionTextView(text: "We use JWT-tokens for authorization, so you don't have to worry about the safety of your data.")
            }
            .padding(.horizontal, 15)
            VStack{
//                if UIScreen.screenHeight > 600 {
                    SignImageView(image: "DataImage")
                        .padding(.all, -15)
               // }
                Divider()
                
                HStack{
                    SignAlternativeButton(
                        icon: Image("appleIcon"),
                        color: Color(.black))
                        .padding(.leading, 15)
                    SignAlternativeButton(
                        icon: Image("facebookIcon"),
                        color: Color("continueWithFacebook"))
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                
                SignCommonTextFieldView(
                    labelText: "Email",
                    icon: Image("emailIconForTextField"),
                    validation: RootAssembly.serviceAssembly.signValidation.isValidEmail(email:),
                    textContentType: .emailAddress,
                    fieldValue: $email)
                    .padding(.bottom, 5)
                    .padding(.horizontal, 10)
                
                SignPasswordTextFieldView(labelText: "Password",
                                          icon: Image("passwordIconForTextField"),
                                          fieldValue: $password)
                    .padding(.horizontal, 10)
            }.padding(.vertical, 10)
            Spacer()
            VStack{
//                SignUp(text: "Log In",
//                           backColor: Color(.black),
//                           isEnabled: RootAssembly.serviceAssembly.signValidation.isValidEmail(email: email)
//                            && RootAssembly.serviceAssembly.signValidation.isValidPassword(password: password))
//                    
//                    .padding(
//                        .init(top: 0,
//                              leading: 0,
//                              bottom: 0.1,
//                              trailing: 0))
//                
                SignUnderlinedTextView(text: "Register")
            }
        }
    }
}

struct SignImageView : View {
    let image: String
    var body : some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
