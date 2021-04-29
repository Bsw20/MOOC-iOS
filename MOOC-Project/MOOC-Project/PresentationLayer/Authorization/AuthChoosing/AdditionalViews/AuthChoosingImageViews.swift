//
//  AuthChoosingImageViews.swift
//  MOOC
//
//  Created by Андрей Самаренко on 05.04.2021.
//

import SwiftUI

#if DEBUG
struct AuthChoosingImageViews: View {
    var body: some View {
        AuthChoosingIntroImageView(image: "IntroImage")
    }
}

struct AuthChoosingImageViews_Previews: PreviewProvider {
    static var previews: some View {
        AuthChoosingImageViews()
    }
}
#endif

struct AuthChoosingIntroImageView: View {
    let image: String
    var body : some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
