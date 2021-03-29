import SwiftUI

struct AuthView: View {
    var body: some View {
            VStack{
                TopView()
                Spacer()
                
                Image("LoginImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                BigBoldText(text: "Where self-education begins!")

                SubText(text: "Quarantine is the perfect time to spend your day to learn something new everyday anywhere.")
                
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
        }
    }
}


struct RoundedRectTextView : View{
    var text : String
    var image : Image
    var backColor : Color
    var body : some View{
        HStack{
            image
                .padding(
                    .init(
                        top: 15,
                        leading: 15,
                        bottom: 15,
                        trailing: 15)
                )
            Text(text)
                .fontWeight(.bold)
                .font(.callout)
                .foregroundColor(.white)
                .frame(
                    maxWidth:  .infinity,
                    maxHeight: 50,
                    alignment: .leading
                )
                .padding(
                    .init(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: 0)
                )
            
        }.background(
            RoundedRectangle(cornerRadius: 15.0)
                        .fill(backColor))
        .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
    }
}


struct BigBoldText : View {
    let text : String
    var body : some View{
        Text(text)
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            .padding(
                .init(
                    top: -15,
                    leading: 15,
                    bottom: 1.5,
                    trailing: 15)
            )
    }
}

struct TopView : View{
    var body : some View{
        ZStack{
            Text("MOOC")
                .fontWeight(.bold)
            HStack{
                Image(systemName: "chevron.backward")
                    .frame(maxWidth: 40,
                           maxHeight: 40)
                    .overlay(Circle()
                                .strokeBorder(Color(.black), lineWidth: 2))
                Spacer()
            }
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 0))
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
                        bottom: 5,
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
                        bottom: 5,
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
                        bottom: 5,
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

struct SubText : View {
    let text : String
    var body : some View{
        Text(text)
            .font(.caption)
            .fontWeight(.light)
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            .padding(
                .init(
                    top: 0,
                    leading: 15,
                    bottom: 0,
                    trailing: 15)
            )
    }
}
