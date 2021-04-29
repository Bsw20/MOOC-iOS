//
//  HUDProgressView.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 25.04.2021.
//

import SwiftUI

struct HUDProgressView: View {
    var placeHolder: String
    @Binding var show: Bool
    @State var animate = false
    
    var body: some View {
        VStack(spacing: 28) {
            Circle()
            // for dark mode adoption
                .stroke(AngularGradient(gradient: .init(colors: [Color.primary, Color.primary.opacity(0)]),
                                    center: .center))
                .frame(width: 80, height: 80)
                .rotationEffect(.init(degrees: animate ? 360 : 0 ))
            
            Text(placeHolder)
                .fontWeight(.bold)
                
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 35)
        .background(BlurView())
        .cornerRadius(20)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .background(Color.primary.opacity(0.35)
                        .onTapGesture {
                            withAnimation {
                                
                            }
                        })
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                animate.toggle()
            }
        }
    }
}

struct BlurView: UIViewRepresentable {
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        return view
    }
}

struct HUDProgress: View {
    @State var m = false
    var body: some View {
        ZStack {
            VStack {
                Button("Hello") {
                    m.toggle()
                }
            }
            
            if m {
                HUDProgressView(placeHolder: "Wait", show: $m)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct HUDProgress_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HUDProgress()
                .environment(\.sizeCategory, .extraLarge)
            HUDProgress()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
#endif
