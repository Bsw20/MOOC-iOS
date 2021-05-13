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
    
    // if still processing
    @State var isLoading: Bool = false
    
    // alert if error occuried or success
    @State var isAlertVisible = false
    
    // occuried error while interacting with server
    @State var error: NetworkError?
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center) {
                SignUpMiddleView(isAlertVisible: $isAlertVisible,
                                 error: $error,
                                 isAnimating: $isLoading)
            }
            .zIndex(0)
            .padding(.top, 5)
            
            if isAlertVisible {
                withAnimation {
                    getAlertForSignUp(error: error,
                                      isVisible: $isAlertVisible)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                if isAlertVisible {
                                    withAnimation {
                                        isAlertVisible.toggle()
                                    }
                                }
                            }
                        }
                        .zIndex(1)
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

struct SignUpMiddleView: View {
    
    // model to interact with services
    @State var model: SignUpProtocol = SignUpModel()
    
    // stored data to register new user
    @State var email: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    
    @Binding var isAlertVisible: Bool
    @Binding var error: NetworkError?
    @Binding var isAnimating: Bool
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading) {
                
                SignBigBoldTextView(text: "Добро пожаловть,")
                
                SignBoldSubTextView(text: "Давайте создадим новый аккаунт!")
                    .minimumScaleFactor(0.5)
                    .padding(.bottom, 10)
                
                SignDescriptionTextView(text: "Чтобы использовать наше приложение вам необходим аккаунт, не беспокойтесь это займет пару минут!")
                // if UIScreen.screenHeight > 640 { }
                WelcomePreviewImageView(image: "CurrentlyInProgress")
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
                SignUp(model: $model,
                       error: $error,
                       isLoading: $isAnimating,
                       isAlertVisible: $isAlertVisible,
                       text: "Зарегестрироваться",
                       backColor: Color(.black),
                       email: $email,
                       userName: $userName,
                       password: $password)
                    .disabled(!model.validateAll(email: email,
                                                 userName: userName,
                                                 password: password))
                    .padding(.bottom, 2)
                
            }
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 10)
        
    }
}
