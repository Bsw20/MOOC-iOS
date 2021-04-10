import SwiftUI

struct AuthChoosing: View {
    var body: some View {
        VStack{
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
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
#endif

struct AuthChoosingTopView : View{
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


struct AuthChoosingMiddleView: View {
    var body: some View {
        VStack{
            AuthChoosingIntroImageView(image: "LoginImage")
            
            AuthChoosingBigBoldTextView(text: "Where self-education begins!")
            
            AuthChoosingSubTextView(
                text: "Quarantine is the perfect time to spend your day to learn something new everyday anywhere.")
                .padding(
                    .init(
                        top: 0,
                        leading: 15,
                        bottom: 0,
                        trailing: 15
                    )
                )
            
        }
        
    }
}

struct AuthChoosingBottomView: View {
    var body : some View {
        VStack{
            AuthChoosingRoundedRectButton(
                text: "Sign in with apple",
                image: Image("appleIcon"),
                //button action here
                backColor: .black, action: {})
                .padding(
                    .init(
                        top: 0,
                        leading: 0,
                        bottom: 0.1,
                        trailing: 0
                    )
                )
            
            AuthChoosingRoundedRectButton(
                text: "Continue with email",
                image: Image("mailIcon"),
                backColor: Color("continueWithEmailColor"), action: {}
            )
            .padding(
                .init(
                    top: 0,
                    leading: 0,
                    bottom: 0.1,
                    trailing: 0
                )
            )
            
            AuthChoosingRoundedRectButton(
                text: "Continue with Facebook",
                image: Image("facebookIcon"),
                backColor: Color("continueWithFacebook"),
                //button action here
                action: {}
            )
            .padding(
                .init(
                    top: 0,
                    leading: 0,
                    bottom: 0.1,
                    trailing: 0
                )
            )
        }.padding(
            .init(
                top: 5,
                leading: 0,
                bottom: 10,
                trailing: 0)
        )
    }
}
