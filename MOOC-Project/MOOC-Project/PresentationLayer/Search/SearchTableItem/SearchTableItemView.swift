//
//  SearchTableItemView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 29.04.2021.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct SearchTableItemView: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    
                    Image("companyIcon")
                        .resizable()
                        .frame(maxWidth: 40, maxHeight: 40)
                    
                    Text("OpenEdu")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.top, 2)
                .padding(.horizontal, 15)
                
                Spacer()
                HStack {
                    Text("Методы и алгоритмы теории графов")
                        .font(.headline)
                        .fontWeight(.medium)
                        .lineLimit(2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.horizontal, 15)

                
            }
            .frame(maxWidth: .infinity, maxHeight: 180)
            .padding(.all, 5)
            .background(
                ZStack {
                    Image("courseDefaultImage")
                        .resizable()
                        .overlay(Color(.black)
                                    .cornerRadius(13, corners: [.topLeft, .topRight])
                                    .opacity(0.7)
                                    )
                }
                .clipped())
            
            HStack {
                ForEach(0..<5) { _ in
                    Image("fullStar")
                        .resizable()
                        .frame(maxWidth: 15, maxHeight: 15)
                }
                Text("(14)")
                    .font(.headline)
                    .foregroundColor(Color(red: 102 / 255.0, green: 102 / 255.0, blue: 102 / 255.0))
                    .fontWeight(.thin)
                    .lineLimit(1)
                
                Spacer()
                Text("12$")
                    .font(.headline)
                    .foregroundColor(Color(red: 102 / 255.0, green: 102 / 255.0, blue: 102 / 255.0))
                    .fontWeight(.thin)
                    .lineLimit(1)
            }
            .padding(.horizontal, 15)
            Text("Become an expert in modelling, lighting, rendering and post production in 3ds Max, V-Ray and Photoshop")
                .font(.headline)
                .foregroundColor(Color(red: 102 / 255.0, green: 102 / 255.0, blue: 102 / 255.0))
                .fontWeight(.light)
                .lineLimit(3)
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
        }
        .background(RoundedRectangle(cornerRadius: 13,
                                      style: .continuous)
                        .fill(Color(.white))
                        .shadow(radius: 6))
        .frame(maxWidth: .infinity, maxHeight: 220)
        .padding(.horizontal, 20)
    }
}

struct SearchTableItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTableItemView()
    }
}
