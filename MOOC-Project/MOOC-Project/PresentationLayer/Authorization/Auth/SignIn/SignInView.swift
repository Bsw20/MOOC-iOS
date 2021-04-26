//
//  AuthInputView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 10.04.2021.
//

import SwiftUI

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

struct SignInView: View {
    
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            AuthInputTopView()
            AuthInputMiddleView(isLoading: $isLoading)
        }
    }
}

struct AuthInputTopView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body : some View {
        ZStack {
            Text("MOOC")
                .fontWeight(.bold)
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
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
    
    @Binding var isLoading: Bool
    
    @State var model: SignInProtocol = SignInModel()
    @State var fieldValue: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                SignBigBoldTextView(text: "Welcome,")
                SignBoldSubTextView(text: "Sign in to continue!")
                    .padding(.bottom)
                SignDescriptionTextView(text: "We use JWT-tokens for authorization, so you don't have to worry about the safety of your data.")
            }
            .padding(.horizontal, 15)
            
            VStack {
                SignImageView(image: "DataImage")
                    .padding(.all, -15)
                Divider()
                
                HStack {
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
                    labelText: "Email or Username",
                    icon: Image("emailIconForTextField"),
                    validation: model.userNameOrEmailValidation(fieldValue:),
                    textContentType: .emailAddress,
                    fieldValue: $fieldValue)
                    .padding(.bottom, 5)
                    .padding(.horizontal, 10)
                
                SignPasswordTextFieldView(labelText: "Password",
                                          icon: Image("passwordIconForTextField"),
                                          fieldValue: $password)
                    .padding(.horizontal, 10)
                
            }.padding(.vertical, 10)
            
            Spacer()
            VStack {
                SignIn(model: $model,
                       text: "Sign In",
                       backColor: Color(.black),
                       animate: $isLoading,
                       fieldValue: $fieldValue,
                       password: $password)
                    .disabled(!model.validateAll(fieldValue: fieldValue,
                                                 password: password))
                    .padding(.bottom, 2)
                    
                SignUnderlinedTextView(text: "Register")
            }
        }
    }
}
