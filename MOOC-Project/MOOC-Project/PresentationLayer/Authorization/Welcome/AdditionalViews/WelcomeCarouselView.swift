//
//  CarouselView.swift
//  MOOC
//
//  Created by Андрей Самаренко on 02.04.2021.
//  (Refactored)

import SwiftUI

#if DEBUG
struct WelcomeCarouselView: View {
    var body: some View {
        WelcomeContentView()
    }
}

struct WelcomeCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeCarouselView()
    }
}
#endif

struct WelcomeCarouselContentView: View {
    var imageName: String
    var text: WelcomeSubTextView
    var body: some View {
        VStack {
            WelcomePreviewImageView(image: imageName)
                .padding(.vertical, -20)
                .padding(.horizontal, 0)
            text
                .padding(.vertical, 0)
                .padding(.horizontal, 8)
        }
        
    }
}

/*
 Carousel View on the WelcomView settings
 */
struct WelcomeContentView: View {
    // timer for swapping views
    public let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    // current selection
    @State private var selection = 0
    
    let contents = [
        WelcomeCarouselContentView(imageName: "CurrentlyInProgress",
                                   text: WelcomeSubTextView(text: "The App is currently in pre-release mode,"
                                                                + " if you find any bugs - contact us as soon as possible!")),
        WelcomeCarouselContentView(imageName: "IntroImage",
                                   text: WelcomeSubTextView(text: "MOOC is a developing platform for finding massive open online courses. "
                                                                + "Join us and find something special just for you!")),
        WelcomeCarouselContentView(imageName: "LoginImage",
                                   text: WelcomeSubTextView(text: "We can find course based on your interests and wishes,"
                                                                + " search, like and comment to get courses that you like!"))
    ]
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                ForEach(0..<3) { i in
                    contents[i]
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            .onReceive(timer, perform: { _ in
                withAnimation {
                    selection = selection < 2 ? selection + 1 : 0
                }
            })
        }
    }
}
