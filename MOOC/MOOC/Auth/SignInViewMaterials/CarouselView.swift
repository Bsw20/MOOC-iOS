//
//  CarouselView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 02.04.2021.
//

import SwiftUI

struct CarouselView: View {
    var body: some View {
        ContentView()
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}

struct Content : View {
    var imageName: String
    var text: SignInViewSubText
    var body: some View {
        VStack {
            ImageView(image: imageName)
                .padding(.init(top: -20,
                               leading: 0,
                               bottom: -20,
                               trailing: 0))
            text
                .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
        }
    }
}

struct ContentView: View {
    public let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State private var selection = 0
    
    let contents = [
        Content(imageName: "CurrentlyInProgress",
                text: SignInViewSubText(text: "The App is currently in pre-release mode, if you find any bugs - contact us as soon as possible!")),
        Content(imageName: "IntroImage",
                text: SignInViewSubText(text: "MOOC is a developing platform for finding massive open online courses. Join us and find something special just for you!")),
        Content(imageName: "LoginImage",
                text: SignInViewSubText(text: "We can find course based on your interests and wishes, search, like and comment to get courses that you like!"))
    ]
    
    var body: some View {
        VStack{
            TabView(selection : $selection){
                ForEach(0..<3){ i in
                    contents[i]
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            .onReceive(timer, perform: { _ in
                withAnimation{
                    print("selection is",selection)
                    selection = selection < 2 ? selection + 1 : 0
                }
            })
            Divider()
        }
    }
}
