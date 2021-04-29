//
//  SignInImageViews.swift
//  MOOC
//
//  Created by Андрей Самаренко on 06.04.2021.

import SwiftUI

#if DEBUG
struct WelcomeImageViews: View {
    var body: some View {
        WelcomePreviewImageView(image: "LoginImage")
    }
}

struct WelcomeImageViews_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeImageViews()
    }
}
#endif

struct WelcomePreviewImageView: View {
    let image: String
    var body : some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
