//
//  SearchTableItemView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 29.04.2021.
//

import SwiftUI

struct SearchTableItemView: View {
    
    var data: CourseParsedShortDataModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    RemoteImage(url: data.vendor.icon)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 40,
                               maxHeight: 40)
                    
                    Text(data.vendor.name)
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
                    Text(data.courseName)
                        .font(.headline)
                        .fontWeight(.medium)
                        .lineLimit(2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.horizontal, 10)
             
            }
            .frame(maxWidth: .infinity, maxHeight: 180)
            .padding(.all, 5)
            .background(
                
                ZStack {
                    RemoteImage(url: data.previewImageLink)
                        .centerCropped()
                        .overlay(Color(.black)
                                    .cornerRadius(13,
                                                  corners: [.topLeft, .topRight])
                                    .opacity(0.7))
                    
                }
                .clipped())
            
            VStack(alignment: .leading) {
            HStack {
                StarsView(rating: CGFloat(data.rating.external.averageScore), maxRating: 5)
                
                Text("(\(data.rating.external.countReviews))")
                    .font(.headline)
                    .foregroundColor(Color(red: 102 / 255.0,
                                           green: 102 / 255.0,
                                           blue: 102 / 255.0))
                    .fontWeight(.thin)
                    .lineLimit(1)
                
                Spacer()
                if let amount = data.price.amount,
                   let currency = data.price.currency {
                    Text(amount == 0 ? "Бесплатно" : "\(String(format: "%.2f", amount)) \(currency)")
                        .font(.headline)
                        .foregroundColor(Color(red: 102 / 255.0,
                                               green: 102 / 255.0,
                                               blue: 102 / 255.0))
                        .fontWeight(.thin)
                        .lineLimit(1)
                } else {
                    Text("FREE")
                        .font(.headline)
                        .foregroundColor(Color(red: 102 / 255.0,
                                               green: 102 / 255.0,
                                               blue: 102 / 255.0))
                        .fontWeight(.thin)
                        .lineLimit(1)
                }
                
            }
            .padding(.horizontal, 15)
            
            Text(data.shortDescription)
                .font(.headline)
                .foregroundColor(Color(red: 102 / 255.0, 
                                       green: 102 / 255.0,
                                       blue: 102 / 255.0))
                .fontWeight(.light)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .frame(alignment: .leading)
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            }
        }
        .background(RoundedRectangle(cornerRadius: 13,
                                      style: .continuous)
                        .fill(Color(.white))
                        .shadow(radius: 6))
        .frame(maxWidth: .infinity, minHeight: 220, maxHeight: 220)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(
            RoundedCorner(radius: radius, corners: corners)
        )
    }
}

extension View {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
                .cornerRadius(13)
            .clipped()
        }
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

struct StarsView: View {
    let rating: CGFloat
    let maxRating: CGFloat
    
    private let size: CGFloat = 20
    var body: some View {
        let text = HStack(spacing: 5) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: size, height: size, alignment: .center)
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: size, height: size, alignment: .center)
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: size, height: size, alignment: .center)
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: size, height: size, alignment: .center)
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: size, height: size, alignment: .center)
        }
        
        ZStack {
            text
            HStack(content: {
                GeometryReader(content: { geometry in
                    HStack(spacing: 0, content: {
                        
                        let width1 = self.valueForWidth(geometry.size.width, value: rating)
                        let width2 = self.valueForWidth(geometry.size.width, value: (maxRating - rating))
                        
                        Rectangle()
                            .frame(width: width1, height: geometry.size.height,
                                   alignment: .center)
                            .foregroundColor(Color(red: 234 / 255.0,
                                                   green: 198 / 255.0,
                                                   blue: 91 / 255.0))
                        
                        Rectangle()
                            .frame(width: width2,
                                   height: geometry.size.height, alignment: .center)
                            .foregroundColor(Color(red: 225 / 255.0,
                                                   green: 225 / 255.0, blue: 224 / 255.0))
                    })
                })
                .frame(width: size * maxRating + 20,
                       height: size + 20,
                       alignment: .trailing)
            })
            .mask(
                text
            )
        }
        .frame(width: size * maxRating + 20, height: size, alignment: .leading)
    }
    
    func valueForWidth(_ width: CGFloat, value: CGFloat) -> CGFloat {
        value * width / maxRating
    }
}
