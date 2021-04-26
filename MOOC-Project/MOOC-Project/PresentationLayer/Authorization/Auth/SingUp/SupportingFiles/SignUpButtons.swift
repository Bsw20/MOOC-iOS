import SwiftUI

struct SignAlternativeButton: View {
    var icon: Image
    var color: Color
    var body: some View {
        Button(action: {}) {
            ZStack {
                Circle()
                    .stroke(Color(.white),
                            lineWidth: 1.5)
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(
                        Circle()
                            .fill(color)
                    )
                icon
            }
        }
    }
}

struct SignUp: View {
    
    @Binding var model: SignUpProtocol
    
    @State var error: NetworkError?
    
    // settings
    var text: String
    var backColor: Color
    
    // is still loading (await for result)
    @Binding var animate: Bool
    
    @State var isAlertVisible: Bool = false
    
    @Binding var email: String
    @Binding var userName: String
    @Binding var password: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body : some View {
        Button(action: {
            animate.toggle()
            model.signUpUser(userData: .init(email: email,
                                             userName: userName,
                                             password: password)) { error in
                self.error = error
                isAlertVisible.toggle()
                animate.toggle()
            }}) {
            HStack {
                Text(text)
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(
                        minWidth: 210, maxWidth: 240,
                        minHeight: 38, maxHeight: 50,
                        alignment: .center
                    )
                
            }
            .background(
                RoundedRectangle(cornerRadius: 13, style: .continuous)
                    .stroke(Color(.white), lineWidth: 1.5)
                    .background(
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill(RootAssembly.serviceAssembly.signValidation.isEnableToContinue(
                                    userName: userName,
                                    email: email,
                                    password: password) ? backColor : Color.gray)
                    )
                
            )
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        .alert(isPresented: $isAlertVisible) {
            getAlert(error: $error.wrappedValue)
        }
    }
}

func getAlert(error: NetworkError?) -> Alert {
    switch error {
    case .badCode(let code):
        if code == 400 {
            return Alert(title: Text("Error"),
                         message: Text("User already exists"),
                         dismissButton: .cancel())
        }
        return Alert(title: Text("Error"),
                     message: Text("Server error"),
                     dismissButton: .cancel())
    default:
        if error != nil {
            return Alert(title: Text("Error"),
                         message: Text("unknown Server error"),
                         dismissButton: .cancel())
        } else {
            return Alert(title: Text("Success"),
                         message: Text("You are successfully logged in"),
                         dismissButton: .cancel())
        }
    }
}
