//
//  CarouselView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 02.04.2021.
//

import SwiftUI

#if DEBUG
struct SignInCarouselView: View {
    var body: some View {
        SignInContentView()
    }
}

struct SignInCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        SignInCarouselView()
    }
}
#endif

struct SignInCarouselContentView : View {
    var imageName: String
    var text: SignInSubTextView
    var body: some View {
        VStack {
            SignInPreviewImageView(image: imageName)
                .padding(.init(
                            top: -20,
                            leading: 0,
                            bottom: -20,
                            trailing: 0)
                )
            text
                .padding(.init(
                    top: 0,
                    leading: 8,
                    bottom: 0,
                    trailing: 8
                ))
        }
    }
}

struct SignInContentView: View {
    public let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State private var selection = 0
    
    let contents = [
        SignInCarouselContentView(imageName: "CurrentlyInProgress",
                text: SignInSubTextView(text: "The App is currently in pre-release mode, if you find any bugs - contact us as soon as possible!")),
        SignInCarouselContentView(imageName: "IntroImage",
                text: SignInSubTextView(text: "MOOC is a developing platform for finding massive open online courses. Join us and find something special just for you!")),
        SignInCarouselContentView(imageName: "LoginImage",
                text: SignInSubTextView(text: "We can find course based on your interests and wishes, search, like and comment to get courses that you like!"))
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
