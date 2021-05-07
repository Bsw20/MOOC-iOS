//
//  ContentView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 18.04.2021.
//

import SwiftUI

struct ContentView: View {
    @State var barImages: [String] = ["magnifyingglass.circle", "star", "gear"]
    @State var barTexts: [String] = ["Поиск", "Главная", "Профиль"]
    @State var isLoggedIn = RootAssembly.serviceAssembly.sessionService.getCurrentSessionValue()
    @State var selectedIndex = 0
    @State var showBottomBar: Bool = true
    
    var body: some View {
        VStack {
            if isLoggedIn {
                
                NavigationView {
                    ZStack {
                        SearchMainView(showBottomBar: $showBottomBar)
                        if showBottomBar {
                            BottomBar(selectedIndex: $selectedIndex,
                                      barImages: $barImages,
                                      barTexts: $barTexts)
                        }
                    }
                    
                }
            } else {
                WelcomeView()
            }
        }
        .animation(.spring())
        .onAppear {
            RootAssembly.serviceAssembly.sessionService.enableObserver(for: "status") {
                self.isLoggedIn = RootAssembly.serviceAssembly.sessionService.getCurrentSessionValue()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BottomBar: View {
    @Binding var selectedIndex: Int
    @Binding var barImages: [String]
    @Binding var barTexts: [String]
    var body: some View {
        HStack {
            ForEach(0..<3) { index in
                Button(action: { withAnimation { selectedIndex = index } },
                       label: {
                        VStack {
                            Image(systemName: barImages[index])
                                .font(.system(size: 30, weight: .medium))
                                .foregroundColor(selectedIndex == index
                                                    ? Color.black
                                                    : Color("textFieldColor"))
                            Text(barTexts[index])
                                .fontWeight(.medium)
                                .foregroundColor(selectedIndex == index
                                                    ? Color.black
                                                    : Color("textFieldColor"))
                        }
                        
                       })
                    .padding(.horizontal, 10)
                    .padding(.all, 5)
            }
        }
        .padding(.horizontal)
        .background(RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white))
        .background(RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("textFieldColor"), lineWidth: 4))
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}
