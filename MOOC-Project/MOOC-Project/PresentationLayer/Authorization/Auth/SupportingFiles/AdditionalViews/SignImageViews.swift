//
//  SignImageViews.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 26.04.2021.
//

import SwiftUI

struct SignImageView: View {
    let image: String
    var body : some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
