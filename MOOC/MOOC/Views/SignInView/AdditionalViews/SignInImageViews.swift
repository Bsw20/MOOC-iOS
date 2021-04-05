//
//  SignInImageViews.swift
//  MOOC
//
//  Created by Андрей Самаренко on 06.04.2021.
//

import SwiftUI

#if DEBUG
struct SignInImageViews: View {
    var body: some View {
        SignInPreviewImageView(image: "LoginImage")
    }
}

struct SignInImageViews_Previews: PreviewProvider {
    static var previews: some View {
        SignInImageViews()
    }
}
#endif

struct SignInPreviewImageView : View {
    let image: String
    var body : some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
