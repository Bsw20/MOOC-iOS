//
//  AuthInputTextFields.swift
//  MOOC
//
//  Created by Андрей Самаренко on 11.04.2021.
//

import SwiftUI

struct AuthInputTextFields: View {
    var body: some View {
        AuthInputTextField(icon: Image("emailIconForTextField"), contentType: .emailAddress,
                       labelText: "Email")
    }
}

#if DEBUG
struct AuthInputTextFields_Previews: PreviewProvider {
    static var previews: some View {
        AuthInputTextFields()
    }
}
#endif

struct AuthInputTextField: View {
    @State private var fieldValue: String = ""
    let icon: Image
    let contentType: UITextContentType
    let labelText: String
    var body: some View {
            HStack{
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(
                        minWidth: 20, maxWidth:  20,
                        minHeight: 20, maxHeight: 40
                    )
                    .foregroundColor(Color("textFieldColor"))
                    .padding(
                        .init(
                            top: 5,
                            leading: 10,
                            bottom: 5,
                            trailing: 5)
                    )
                TextField(labelText, text: $fieldValue)
                    .textContentType(contentType)
                    .font(Font.body.weight(.medium))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .modifier(AuthInputTextFieldClearButton(text: $fieldValue))
                    .padding(
                        .trailing)
                
            }.background(
                RoundedRectangle(cornerRadius: 15,
                                 style: .continuous)
                    .stroke(Color("textFieldColor"),
                            lineWidth: 1.2)
                
            )
            .padding(
                .init(top: 0,
                      leading: 12,
                      bottom: 0,
                      trailing: 12)
            )
    }
}



struct AuthInputTextFieldClearButton: ViewModifier {
    
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "delete.left")
                            .foregroundColor(Color("textFieldColor"))
                    }
                )
            }
        }
    }
}
