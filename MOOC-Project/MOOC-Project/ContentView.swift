//
//  ContentView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 18.04.2021.
//

import SwiftUI

struct ContentView: View {
    @State var isLoggedIn = RootAssembly.serviceAssembly.sessionService.getCurrentSessionValue()
    var body: some View {
        VStack {
            if isLoggedIn {
                EmptyView()
            } else {
                WelcomeView()
            }
        }
        .animation(.spring())
        .onAppear {
            RootAssembly.serviceAssembly.sessionService.enableObserver(for: "status"){
                self.isLoggedIn = RootAssembly.serviceAssembly.sessionService.getCurrentSessionValue()
                
            }
        }
    }
}

prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
