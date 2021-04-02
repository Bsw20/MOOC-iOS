import SwiftUI

struct AuthView: View {
    var body: some View {
            VStack{
                TopView()
                Spacer()
                
                IntroImage(image: "LoginImage")

                VStack {
                    BigBoldText(text: "Where self-education begins!")

                    SubText(text: "Quarantine is the perfect time to spend your day to learn something new everyday anywhere.").padding(
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
            RoundedRectTextView(
                text: "Sign in with apple",
                image: Image("appleIcon"),
                backColor: .black)
                .padding(
                    .init(
                        top: 0,
                        leading: 0,
                        bottom: 0.1,
                        trailing: 0
                    )
                )
            
            RoundedRectTextView(
                text: "Continue with email",
                image: Image("mailIcon"),
                backColor: Color("continueWithEmailColor")
            )
                .padding(
                    .init(
                        top: 0,
                        leading: 0,
                        bottom: 0.1,
                        trailing: 0)
                )
            
            RoundedRectTextView(
                text: "Continue with Facebook",
                image: Image("facebookIcon"),
                backColor: Color("continueWithFacebook")
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

struct IntroImage : View {
    let image: String
    var body : some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            
    }
}
