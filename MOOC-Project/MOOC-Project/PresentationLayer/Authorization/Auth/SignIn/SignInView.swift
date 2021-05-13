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
    @State var isAlertVisible = false
    
    @State var error: NetworkError?
    
    var body: some View {
        ZStack {
            VStack {
                AuthInputTopView()
                AuthInputMiddleView(isLoading: $isLoading,
                                    isAlertVisible: $isAlertVisible,
                                    error: $error)
            }
            .zIndex(0)
            
            if isAlertVisible {
                withAnimation {
                    getAlertForSignIn(error: error,
                                      isVisible: $isAlertVisible)
                        .zIndex(1)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                if isAlertVisible {
                                    withAnimation {
                                        isAlertVisible.toggle()
                                    }
                                }
                            }
                        }
                }
            }
            
            if isLoading {
                HUDProgressView(placeHolder: "Please Wait",
                                show: $isLoading)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(2)
            }
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
                }, label: {
                    Image(systemName: "chevron.backward")
                        .frame(maxWidth: 40,
                               maxHeight: 40)
                        .foregroundColor(Color("headerTextColor"))
                        .overlay(Circle()
                                    .strokeBorder(
                                        Color("headerTextColor"),
                                        lineWidth: 2)
                        )
                })
                Spacer()
            }
            .padding(.leading, 15)
        }
    }
}

struct AuthInputMiddleView: View {
    
    @Binding var isLoading: Bool
    @Binding var isAlertVisible: Bool
    @Binding var error: NetworkError?
    
    @State var model: SignInProtocol = SignInModel()
    @State var fieldValue: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                SignBigBoldTextView(text: "Добро пожаловть,")
                SignBoldSubTextView(text: "Войдите в аккаунт, чтобы продолжить!")
                    .padding(.bottom)
                SignDescriptionTextView(text: "Мы используем JWT токены, так что вы можете смело доверять нам свои данные!")
            }
            .padding(.horizontal, 15)
            
            VStack {
                SignImageView(image: "DataImage")
                    .padding(.all, -15)
                Divider()
                
                HStack {
                    SignAlternativeButton(icon: Image("appleIcon"),
                                          color: Color(.black))
                        .padding(.leading, 15)
                    
                    SignAlternativeButton(icon: Image("facebookIcon"),
                                          color: Color("continueWithFacebook"))
                    Spacer()
                }
                .hidden()
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                
                SignCommonTextFieldView(labelText: "Email or Username",
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
                       text: "Авторизоваться",
                       backColor: Color(.black),
                       animate: $isLoading,
                       error: $error,
                       isAlertVisible: $isAlertVisible,
                       fieldValue: $fieldValue,
                       password: $password)
                    .disabled(!model.validateAll(fieldValue: fieldValue,
                                                 password: password))
                    .padding(.bottom, 2)
                    
            }
        }
    }
}
