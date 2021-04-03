import SwiftUI

struct AuthView: View {
    var body: some View {
            VStack{
                TopView()
                Spacer()
                
                ImageView(image: "LoginImage")

                VStack {
                    AuthViewBigBoldText(text: "Where self-education begins!")

                    AuthViewSubText(text: "Quarantine is the perfect time to spend your day to learn something new everyday anywhere.").padding(
                        .init(
                            top: 0,
                            leading: 15,
                            bottom: 0,
                            trailing: 15)
                    )
                }
                Spacer()
                BottomView()
            }
            .padding(.bottom)
    }
}


struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthView()
                .environment(\.sizeCategory, .extraLarge)
            AuthView()
                    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}

struct BottomView: View {
    var body : some View {
        VStack{
            AuthViewRoundedRectButton(
                text: "Sign in with apple",
                image: Image("appleIcon"),
                backColor: .black, action: {})
                .padding(
                    .init(
                        top: 0,
                        leading: 0,
                        bottom: 0.1,
                        trailing: 0
                    )
                )
            
            AuthViewRoundedRectButton(
                text: "Continue with email",
                image: Image("mailIcon"),
                backColor: Color("continueWithEmailColor"), action: {}
            )
                .padding(
                    .init(
                        top: 0,
                        leading: 0,
                        bottom: 0.1,
                        trailing: 0)
                )
            
            AuthViewRoundedRectButton(
                text: "Continue with Facebook",
                image: Image("facebookIcon"),
                backColor: Color("continueWithFacebook"), action: {}
            )
                .padding(
                    .init(
                        top: 0,
                        leading: 0,
                        bottom: 0.1,
                        trailing: 0)
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

struct TopView : View{
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
                                    .strokeBorder(Color("headerTextColor"), lineWidth: 2))
                }
                
                Spacer()
            }
            .padding(
                .init(top: 0,
                      leading: 15,
                      bottom: 0,
                      trailing: 0)
            )
        }
    }
}
