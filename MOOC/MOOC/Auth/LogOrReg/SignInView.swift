//
//  SignInView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 29.03.2021.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        Menu()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

struct Menu: View {
    var body: some View {
        VStack{
            TopBar()
        }
    }
}

struct TopBar: View {
    var body: some View {
        VStack{
            Button(action: {}){
                            Image("backButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
        }
    }
}
