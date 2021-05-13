import SwiftUI
import FBSDKLoginKit

struct AuthChoosing: View {
    
    var body: some View {
        VStack {
            AuthChoosingTopView()
            Spacer()
            AuthChoosingMiddleView()
            Spacer()
            AuthChoosingBottomView()
        }
        .padding(.bottom)
    }
}

#if DEBUG
struct AuthChoosing_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthChoosing()
                .environment(\.sizeCategory, .extraLarge)
            AuthChoosing()
                .preferredColorScheme(.dark)
        }
    }
}
#endif

struct AuthChoosingTopView: View {
    
    // to enable dismiss from current view
    @Environment(\.presentationMode) var presentationMode
    
    var body : some View {
        ZStack {
            Text("MOOC")
                .fontWeight(.bold)
            
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
                    Image(systemName: "chevron.backward")
                        .frame(maxWidth: 40,
                               maxHeight: 40)
                        .foregroundColor(Color("headerTextColor"))
                        .overlay(Circle()
                                    .strokeBorder(Color("headerTextColor"),
                                                  lineWidth: 2))
                })
                
                Spacer()
            }
            .padding(.leading, 15)
            .padding(.top, 5)
        }
    }
}

struct AuthChoosingMiddleView: View {
    var body: some View {
        VStack {
            AuthChoosingIntroImageView(image: "LoginImage")
            AuthChoosingBigBoldTextView(text: "Где самообразование берет свои истоки!")

                .padding(.top, -15)
                .padding(.bottom, 1.5)
            
            AuthChoosingSubTextView(
                text: "Карантин - лучшая пора, что бы учиться чему то новому каждый день, в любом месте, в любое время!")
               
        } .padding(.horizontal, 20)
    }
}

struct AuthChoosingBottomView: View {
    
    @State var manager = LoginManager()
    // for email-button
    @State var emailRegistrationViewIsPresented = false
    
    var body : some View {
        VStack(spacing: 5) {
            
            AuthChoosingRoundedRectButton(
                text: "Sign up with apple",
                image: Image("appleIcon"),
                // button action here
                backColor: .black,
                action: {}).hidden()
                
            AuthChoosingRoundedRectButton(
                text: "Продолжить с почтой",
                image: Image("mailIcon"),
                backColor: Color("continueWithEmailColor"),
                action: { emailRegistrationViewIsPresented.toggle()})
            .sheet(isPresented: $emailRegistrationViewIsPresented, content: {
                SignUpView()
            })

            AuthChoosingRoundedRectButton(
                text: "Continue with Facebook",
                image: Image("facebookIcon"),
                backColor: Color("continueWithFacebook"),
                // button action here
                action: {
                    /*
                    manager.logIn(permissions: ["public_profile", "email"], from: nil) { (res, err) in
                        if let err = err {
                            print(err.localizedDescription)
                            return
                        }
                        
                        let request = GraphRequest(graphPath: "me", parameters: ["fields": "email"])
                        
                        request.start { (_, res, _) in
                            guard let profileData = res as? [String: Any] else {
                                return
                            }
                        }
                    }*/
                }
            ).hidden()
        }
        .padding(.top, 5)
        .padding(.bottom, 10)
    }
}
