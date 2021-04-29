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
                    .frame(width: 40,
                           height: 40,
                           alignment: .center)
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
    
    // model to interact with services
    @Binding var model: SignUpProtocol
    // error occuried while signing up
    @Binding var error: NetworkError?
    
    // is still loading (await for result)
    @Binding var isLoading: Bool
    // alert visible
    @Binding var isAlertVisible: Bool
    
    // settings
    var text: String
    var backColor: Color
    
    // content
    @Binding var email: String
    @Binding var userName: String
    @Binding var password: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body : some View {
        Button(action: {
                isLoading.toggle()
                model.signUpUser(userData: .init(email: email,
                                                 userName: userName,
                                                 password: password)) { error in
                    if let error = error {
                        self.error = error
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            presentationMode.wrappedValue.dismiss()
                            model.changeSessionStatus()
                        }
                    }
                    isAlertVisible.toggle()
                    isLoading.toggle()
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
                RoundedRectangle(cornerRadius: 13,
                                 style: .continuous)
                    .stroke(Color(.white),
                            lineWidth: 1.5)
                    .background(
                        RoundedRectangle(cornerRadius: 13,
                                         style: .continuous)
                            .fill(model.validateAll(email: email,
                                                    userName: userName,
                                                    password: password)
                                    ? backColor
                                    : Color.gray)
                    )
            )
            .padding(.horizontal, 15)
        }
    }
}
