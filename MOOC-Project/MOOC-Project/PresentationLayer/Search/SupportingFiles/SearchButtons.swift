//
//  SearchButtons.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 02.05.2021.
//

import SwiftUI

struct SearchButtons: View {
    var body: some View {
        SearchRoundedRectButton(text: "Load more",
                                action: {})
    }
}

struct SearchButtons_Previews: PreviewProvider {
    static var previews: some View {
        SearchButtons()
    }
}

struct SearchRoundedRectButton: View {
    
    var text: String
    // action by tappind the button
    var action: (() -> Void)
    
    var body: some View {
        
        Button(action: { action() },
               label: {
                Text(text.uppercased())
                    .fontWeight(.black)
                    .font(.callout)
                    .foregroundColor(.black)
                    .frame(
                        minWidth: 170, maxWidth: 170,
                        minHeight: 38, maxHeight: 50,
                        alignment: .center
                    )
            }).background(
                RoundedRectangle(cornerRadius: 13,
                                 style: .continuous)
                    .stroke(Color(.black),
                            lineWidth: 1.5)
                    .background(
                        RoundedRectangle(cornerRadius: 20,
                                         style: .continuous)
                            .fill(Color.white)
                    )
            )
            .padding(.vertical, 0)
            .padding(.horizontal, 15)
        }
    }
