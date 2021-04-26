//
//  SignInButtons.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 26.04.2021.
//

import SwiftUI

struct SignIn: View {
    
    @Binding var model: SignInProtocol
    
    // settings
    var text: String
    var backColor: Color
    
    // is still loading (await for result)
    @Binding var animate: Bool
    
    @State var error: NetworkError?
    @State var isAlertVisible: Bool = false
    
    @Binding var fieldValue: String
    @Binding var password: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body : some View {
        Button(action: {
                animate.toggle()
                model.signInUser(userData: model.createUserData(fieldValue: fieldValue,
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
                            .fill(model.validateAll(fieldValue: fieldValue,
                                                    password: password) ? backColor : Color.gray))
            )
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        .alert(isPresented: $isAlertVisible) {
            getAlert(error: $error.wrappedValue)
        }
    }
}
