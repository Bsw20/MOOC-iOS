//
//  AuthInputTextFields.swift
//  MOOC
//
//  Created by Андрей Самаренко on 11.04.2021.
//

import SwiftUI

struct SignTextFields: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var isEmailFilledCorrectly: Bool
    
    var body: some View {
        SignPasswordTextFieldView(labelText: "Pass",
                                  icon: Image("passwordIconForTextField"),
                                  fieldValue: $password)
    }
}

#if DEBUG
struct SignTextFields_Previews: PreviewProvider {
    @State static var email = ""
    static private var password = Binding.constant("")
    @State static var isEmailedFilled: Bool = true
    
    static var previews: some View {
        SignTextFields(
            email: $email,
            password: password,
            isEmailFilledCorrectly: $isEmailedFilled)
    }
}
#endif

struct SignTextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
                .frame(
                    minHeight: 20, maxHeight: 40
                )
                .padding(.init(
                            top: 5,
                            leading: 10,
                            bottom: 5,
                            trailing: 5)
                )
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

struct SignCommonTextFieldView: View{
    var labelText: String
    var icon: Image
    var validation: ((String) -> Bool)
    var textContentType: UITextContentType
    
    @Binding var fieldValue: String
    
    @State private var editing: Bool = false
    @State private var isFilledCorrectlyInner: Bool = true
    
    var body: some View{
        VStack{
            HStack{
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(
                        minWidth: 20, maxWidth:  20,
                        minHeight: 40, maxHeight: 40
                    )
                    .foregroundColor(Color("textFieldColor"))
                    .padding(
                        .init(
                            top: 5,
                            leading: 10,
                            bottom: 5,
                            trailing: 5)
                    )
                TextField(labelText, text: $fieldValue, onEditingChanged: {isChanged in
                    if !isChanged {
                        if validation(self.fieldValue) {
                            self.isFilledCorrectlyInner = true
                        } else {
                            self.isFilledCorrectlyInner = false
                            self.fieldValue = ""
                        }
                        editing = false
                    }else{
                        editing = true
                    }
                })
                .textContentType(textContentType)
                .font(Font.body.weight(.medium))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .modifier(SignTextFieldClearButton(text: $fieldValue))
                .padding(
                    .trailing)
                
            }.background(
                RoundedRectangle(cornerRadius: 15,
                                 style: .continuous)
                    .stroke(
                        (editing ?
                                Color.blue : (isFilledCorrectlyInner ?
                                Color("textFieldColor")
                                : Color(.red)))
                            , lineWidth: 1.2)
            )
        }
        .padding(
            .init(top: 0,
                  leading: 12,
                  bottom: 0,
                  trailing: 12)
        )
    }
}



struct SignPasswordTextFieldView: View{
    var labelText: String
    var icon: Image
   
    @Binding var fieldValue: String
    @State private var editing: Bool = false
    @State private var showText: Bool = false
    
    var body: some View{
        VStack{
            HStack{
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(
                        minWidth: 20, maxWidth:  20,
                        minHeight: 40, maxHeight: 40
                    )
                    .foregroundColor(Color("textFieldColor"))
                    .padding(
                        .init(
                            top: 5,
                            leading: 10,
                            bottom: 5,
                            trailing: 5)
                    )
                if showText {
                    TextField(labelText,
                              text: $fieldValue,
                              onEditingChanged: { isChanged in
                                editing = isChanged
                              })
                    .textContentType(.emailAddress)
                    .font(Font.body.weight(.medium))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .modifier(SignTextFieldClearButton(text: $fieldValue))
                    .padding(
                        .trailing)
                } else {
                    SecureField(labelText,
                                text: $fieldValue)
                    .textContentType(.password)
                    .font(Font.body.weight(.medium))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .modifier(SignTextFieldClearButton(text: $fieldValue))
                    .padding(
                        .trailing)
                }
                
                
                Button(action: {
                                showText.toggle()
                            }, label: {
                                Image(systemName: showText ? "eye.fill" : "eye.slash.fill")
                            })
                .accentColor(Color("textFieldColor"))
                .padding(
                    .init(
                        top: 5,
                        leading: 5,
                        bottom: 5,
                        trailing: 10)
                )
                    
            }.background(
                RoundedRectangle(cornerRadius: 15,
                                 style: .continuous)
                    .stroke(
                        (editing ?
                                Color.blue :
                                Color("textFieldColor"))
                            , lineWidth: 1.2)
            )
        }
        .padding(
            .init(top: 0,
                  leading: 12,
                  bottom: 0,
                  trailing: 12)
        )
    }
}



