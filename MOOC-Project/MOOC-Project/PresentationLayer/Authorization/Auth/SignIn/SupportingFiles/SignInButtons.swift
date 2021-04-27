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
    
    @Binding var error: NetworkError?
    @Binding var isAlertVisible: Bool
    
    @Binding var fieldValue: String
    @Binding var password: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body : some View {
        Button(action: {
                animate.toggle()
                model.signInUser(userData: model.createUserData(fieldValue: fieldValue,
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
                RoundedRectangle(cornerRadius: 13,
                                 style: .continuous)
                    .stroke(Color(.white),
                            lineWidth: 1.5)
                    .background(
                        RoundedRectangle(cornerRadius: 13,
                                         style: .continuous)
                            .fill(model.validateAll(fieldValue: fieldValue,
                                                    password: password)
                                    ? backColor
                                    : Color.gray))
            )
            .padding(.horizontal, 15)
        }
    }
}
