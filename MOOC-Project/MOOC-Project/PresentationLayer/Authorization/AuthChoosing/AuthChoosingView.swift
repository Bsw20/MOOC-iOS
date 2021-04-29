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
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.backward")
                        .frame(maxWidth: 40,
                               maxHeight: 40)
                        .foregroundColor(Color("headerTextColor"))
                        .overlay(Circle()
                                    .strokeBorder(Color("headerTextColor"),
                                                  lineWidth: 2))
                }
                
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
            AuthChoosingBigBoldTextView(text: "Where self-education begins!")
                .padding(.horizontal, 15)
                .padding(.top, -15)
                .padding(.bottom, 1.5)
            
            AuthChoosingSubTextView(
                text: "Quarantine is the perfect time to spend your day to learn something new everyday anywhere.")
                .padding(.horizontal, 15)
        }
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
                action: {})
                
            AuthChoosingRoundedRectButton(
                text: "Continue with email",
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
            )
        }
        .padding(.top, 5)
        .padding(.bottom, 10)
    }
}
