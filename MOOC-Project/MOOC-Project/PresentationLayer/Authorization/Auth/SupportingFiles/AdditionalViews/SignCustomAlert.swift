//
//  SignCustomAlert.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 27.04.2021.
//

import SwiftUI

struct AlertResult {
    var image: String
    var header: String
}

struct SignCustomAlert: View {
    @Binding var show: Bool
    var type: AlertResult
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            VStack(spacing: 25) {
                Image(type.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200, maxHeight: 200)
                Text(type.header.uppercased())
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(Color("headerTextColor"))
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(BlurView())
            .cornerRadius(25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.primary.opacity(0.35)
                .onTapGesture {
                    withAnimation {
                        show.toggle()
                    }
                }
        ).ignoresSafeArea(.all)
        
    }
}

struct SignCustomAlert_Previews: PreviewProvider {
    @State static var show = true
    static var previews: some View {
        SignCustomAlert(show: $show,
                        type: .init(
                                    image: "success",
                                    header: "LOGGED IN"))
    }
}

func getAlertForSignUp(error: NetworkError?, isVisible: Binding<Bool> ) -> SignCustomAlert {
    switch error {
    case .badCode(let code):
        if code == 400 {
            return SignCustomAlert(show: isVisible, type:
                                    .init(image: "error",
                                          header: "user exists"))
        }
        return SignCustomAlert(show: isVisible,
                               type: .init(image: "error",
                                           header: "server error"))
    default:
        if error != nil {

        return SignCustomAlert(show: isVisible,
                               type: .init(image: "error",
                                           header: "server error"))
        } else {
            return SignCustomAlert(show: isVisible,
                                   type: .init(image: "success",
                                               header: "signed up"))
        }
    }
}

func getAlertForSignIn(error: NetworkError?, isVisible: Binding<Bool>) -> SignCustomAlert {
    switch error {
    case .badCode(code: let code):
        if code == 401 {
            return SignCustomAlert(show: isVisible, type:
                                    .init(image: "error",
                                          header: "incorrect login/password"))
        }
        return SignCustomAlert(show: isVisible, type:
                                .init(image: "error",
                                      header: "Server error"))
    default:
        if error != nil {
            return SignCustomAlert(show: isVisible,
                                   type: .init(image: "error", header: "Server error"))
        } else {
            return SignCustomAlert(show: isVisible,
                                   type: .init(
                                    image: "success",
                                    header: "SINGED IN"))
        }
    }
}
