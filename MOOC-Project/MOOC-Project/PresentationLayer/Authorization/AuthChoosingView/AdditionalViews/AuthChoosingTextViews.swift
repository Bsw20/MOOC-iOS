//
//  TextViews.swift
//  MOOC
//
//  Created by Андрей Самаренко on 02.04.2021.
//

import SwiftUI

#if DEBUG
struct AuthChoosingTextViews: View {
    var body: some View {
        VStack {
            AuthChoosingBigBoldTextView(text: "Massive open online courses")
            AuthChoosingSubTextView(text: "Hi, i am new here, maybe some advices or something, i don't know")
        }
    }
}

struct AuthChoosingTextViews_Previews: PreviewProvider {
    static var previews: some View {
        AuthChoosingTextViews()
    }
}
#endif

struct AuthChoosingBigBoldTextView: View {
    let text: String
    var body : some View {
        Text(text)
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("headerTextColor"))
            .multilineTextAlignment(.leading)
            .padding(
                .init(
                    top: -15,
                    leading: 15,
                    bottom: 1.5,
                    trailing: 15)
            )
    }
}

struct AuthChoosingSubTextView: View {
    let text: String
    var body : some View {
        Text(text)
            .font(.caption)
            .fontWeight(.light)
            .foregroundColor(Color("headerTextColor"))
            .multilineTextAlignment(.leading)
    }
}
