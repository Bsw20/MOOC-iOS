//
//  ContentView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 18.04.2021.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: Bool = false
    @State var barImages: [String] = ["magnifyingglass.circle", "star", "person.crop.circle"]
    @State var barTexts: [String] = ["Поиск", "Главная", "Профиль"]
    @State var isLoggedIn = RootAssembly.serviceAssembly.sessionService.getCurrentSessionValue()
    @State var selectedIndex = 0
    @State var showBottomBar: Bool = true
    
    var body: some View {
        ZStack {
        VStack {
            if isLoggedIn {
                NavigationView {
                    ZStack {
                        switch selectedIndex {
                        case 0:
                            SearchMainView(showBottomBar: $showBottomBar)
                                .background(Image("searchBack")
                                                .resizable()
                                                .scaledToFit())
                        case 1:
                            SearchMainView(showBottomBar: $showBottomBar)
                        case 2:
                            
                                ProfileMainView(isLoading: $isLoading)
                                    .background(VStack {
                                        Spacer()
                                        Image("IntroImage")
                                                    .resizable()
                                                    .scaledToFit()
                                    })
                        default:
                            SearchMainView(showBottomBar: $showBottomBar)
                        }
                        
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
            if isLoading {
                HUDProgressView(placeHolder: "Please Wait",
                                show: $isLoading)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(2)
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
                Spacer()
                Button(action: { withAnimation { selectedIndex = index } },
                       label: {
                        VStack {
                            Image(systemName: barImages[index])
                                .font(.system(size: 27, weight: .regular))
                                .foregroundColor(selectedIndex == index
                                                    ? Color.black
                                                    : Color("textFieldColor"))
                            Text(barTexts[index])
                                .fontWeight(.medium)
                                .foregroundColor(selectedIndex == index
                                                    ? Color.black
                                                    : Color("textFieldColor"))
                        }
                        .padding(.vertical, 5)
                       })
                Spacer()
            }
        }
        .background(RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(radius: 4))
        .frame(
            maxHeight: .infinity,
               alignment: .bottom)
        .padding(.horizontal, 15)
    }
}
