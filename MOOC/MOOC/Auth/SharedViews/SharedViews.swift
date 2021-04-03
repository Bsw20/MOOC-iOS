//
//  SharedViews.swift
//  MOOC
//
//  Created by Андрей Самаренко on 02.04.2021.
//

import SwiftUI
import Combine

struct SharedViews: View {
    var body: some View {
        ImageView(image: "IntroImage")
    }
}

struct SharedViews_Previews: PreviewProvider {
    static var previews: some View {
        SharedViews()
    }
}

struct ImageView : View {
    let image: String
    var body : some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)            
    }
}

