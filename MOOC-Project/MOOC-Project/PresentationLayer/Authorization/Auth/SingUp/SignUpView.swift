import SwiftUI

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

struct SignUpView: View {
    
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                SignUpMiddleView(isAnimating: $isLoading)
            }
            .padding(.top, 5)
            
            if isLoading {
                HUDProgressView(placeHolder: "Please Wait", show: $isLoading)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct SignUpMiddleView: View {
    
    @State var model: SignUpProtocol = SignUpModel()
    
    // stored data to register new user
    @State var email: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    
    @Binding var isAnimating: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                SignBigBoldTextView(
                    text: "Welcome,")
                
                SignBoldSubTextView(
                    text: "Let's create new account!")
                    .minimumScaleFactor(0.5)
                    .padding(.bottom, 10)
                
                SignDescriptionTextView(
                    text: "To use our app you have to create an account, it’ll only take few moments")
                // if UIScreen.screenHeight > 640 { }
                
                    WelcomePreviewImageView(
                        image: "CurrentlyInProgress")
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 5)
            
            Spacer()
            
            // fields for user to fill
            VStack(spacing: 12) {
                
                SignCommonTextFieldView(
                    labelText: "Name",
                    icon: Image(systemName: "person.crop.circle"),
                    validation: model.validateUserName(userName:),
                    textContentType: .username,
                    fieldValue: $userName)
                
                SignCommonTextFieldView(
                    labelText: "Email",
                    icon: Image("emailIconForTextField"),
                    validation: model.validateEmail(email:),
                    textContentType: .emailAddress,
                    fieldValue: $email)
                
                SignPasswordTextFieldView(
                    labelText: "Password",
                    icon: Image("passwordIconForTextField"),
                    fieldValue: $password)
                
            }
            .padding(.bottom, 15)
            
            // button to send registration request
            VStack {
                
                SignUp(
                    model: $model,
                    text: "Sign In",
                    backColor: Color(.black),
                    animate: $isAnimating,
                    email: $email,
                    userName: $userName,
                    password: $password
                )
                .disabled(!model.validateAll(
                            email: email,
                            userName: userName,
                            password: password))
                .padding(.bottom, 2)
                
                SignUnderlinedTextView(text: "Register")
            }
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 10)
        
    }
}
