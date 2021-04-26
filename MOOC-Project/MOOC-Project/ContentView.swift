//
//  ContentView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 18.04.2021.
//

import SwiftUI

struct ContentView: View {
    @State static var isLoggedIn = false
    var body: some View {
       WelcomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
