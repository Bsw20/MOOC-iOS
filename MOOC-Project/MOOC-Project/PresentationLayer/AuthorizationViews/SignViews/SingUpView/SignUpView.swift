//
//  AuthInputView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 10.04.2021.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack{
            SignUpTopView()
                .padding(.top, 5)
            SignUpMiddleView()
        }
    }
}

#if DEBUG
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView()
                .environment(\.sizeCategory, .extraLarge)
            SignUpView()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
#endif


struct SignUpTopView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body : some View{
        ZStack{
            Text("MOOC")
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.leading, 15)
    }
}

struct SignUpMiddleView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    
    @State var value: CGFloat = 0
    @State var isSignUpButtonEnabled = false
    
    var body: some View {
        ScrollView{
                VStack(alignment: .leading){
                    SignBigBoldTextView(text: "Welcome,")
                    SignBoldSubTextView(text: "Let's create new account!")
                        .minimumScaleFactor(0.5)
                        .padding(.bottom, 10)
                    SignDescriptionTextView(text: "To use our app you have to create an account, it’ll only take few moments")
                    if UIScreen.screenHeight > 640 {
                        WelcomePreviewImageView(image: "CurrentlyInProgress")
                    }
                    
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 5)
            Spacer()
            VStack(spacing: 12){
                
                SignCommonTextFieldView(
                    labelText: "Name",
                    icon: Image(systemName: "person.crop.circle"),
                    validation: RootAssembly.serviceAssembly.signValidation.isValidUserName(userName:),
                    textContentType: .username,
                    fieldValue: $userName)
                
                
                SignCommonTextFieldView(
                    labelText: "Email",
                    icon: Image("emailIconForTextField"),
                    validation: RootAssembly.serviceAssembly.signValidation.isValidEmail(email:),
                    textContentType: .emailAddress,
                    fieldValue: $email)
                
                
                SignPasswordTextFieldView(
                    labelText: "Password",
                    icon: Image("passwordIconForTextField"),
                    fieldValue: $password)
                
            }
            .padding(.bottom, 15)
            VStack{
                SignButton(text: "Sign In",
                           backColor: Color(.black),
                           isEnabled: RootAssembly.serviceAssembly.signValidation.isEnableToContinue(
                            userName: userName,
                            email: email,
                            password: password)
                )
                .disabled(!RootAssembly.serviceAssembly.signValidation.isEnableToContinue(
                            userName: userName,
                            email: email,
                            password: password))
                .padding(
                    .init(top: 0,
                          leading: 0,
                          bottom: 0.1,
                          trailing: 0))
                SignUnderlinedTextView(text: "Register")
            }
        }
        .padding(.horizontal, 5)
        
    }
}

struct SignUpImageView : View {
    let image: String
    var body : some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
