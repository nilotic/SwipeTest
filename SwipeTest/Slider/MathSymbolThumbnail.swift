// 
//  MathSymbolModifier.swift
//
//  Created by Den Jo on 2021/07/22.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct MathSymbolModifier: AnimatableModifier {
    
    // MARK: - Value
    // MARK: Public
    let ratio: CGFloat
    
    
    // MARK: Private
    private let width: CGFloat  = 2
    private let length: CGFloat = 5
    
    private var foregroundColor: Color {
        guard let source = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor.components, let target = #colorLiteral(red: 0.4929926395, green: 0.2711846232, blue: 0.9990822673, alpha: 1).cgColor.components else { return Color.white }
        let red   = Double(source[0] + (target[0] - source[0]) * ratio)
        let green = Double(source[1] + (target[1] - source[1]) * ratio)
        let blue  = Double(source[2] + (target[2] - source[2]) * ratio)
        
        return Color(red: red, green: green, blue: blue)
    }
    
    private var pathColor: Color {
        guard let source = #colorLiteral(red: 0.3831982911, green: 0.3995684385, blue: 0.442784667, alpha: 1).cgColor.components, let target = #colorLiteral(red: 0.8319794536, green: 0.7592350245, blue: 1, alpha: 1).cgColor.components else { return Color.white }
        let red   = Double(source[0] + (target[0] - source[0]) * ratio)
        let green = Double(source[1] + (target[1] - source[1]) * ratio)
        let blue  = Double(source[2] + (target[2] - source[2]) * ratio)
        
        return Color(red: red, green: green, blue: blue)
    }
    
    // MARK: - View
    // MARK: Public
    func body(content: Content) -> some View {
        
        content
            .foregroundColor(foregroundColor)
            .shadow(color: .white, radius: 7)
            .overlay(
                GeometryReader { proxy in
                    ZStack {
                        Group {
                            RoundedRectangle(cornerRadius: ratio)
                                .frame(width: proxy.size.width / 2, height: width)
                                .rotationEffect(Angle(radians: Double(ratio) * .pi / 4))
                            
                            
                            Circle()
                                .frame(width: length / 2, height: length / 2)
                                .padding(.bottom, proxy.size.width / 3)
                                .rotationEffect(Angle(radians: Double(ratio) * .pi / 4))
                                .opacity(Double(1 - ratio))
                                
                            Circle()
                                .frame(width: length / 2, height: length / 2)
                                .padding(.top, proxy.size.width / 3)
                                .rotationEffect(Angle(radians: Double(ratio) * .pi / 4))
                                .opacity(Double(1 - ratio))
                            /*
                            RoundedRectangle(cornerRadius: (length / 2) - (length - width) / 2 * ratio)
                                .frame(width: length + (proxy.size.width / 4 - length) * ratio, height: length - (length - width) * ratio)
                                .padding(.bottom, proxy.size.width / 3)
                                .rotationEffect(Angle(radians: Double(ratio) * .pi / -4), anchor: .topTrailing)
                                .offset(x: width * ratio, y: -width / length * ratio)
                            
                            RoundedRectangle(cornerRadius: (length / 2) - (length - width) / 2 * ratio)
                                .frame(width: length + (proxy.size.width / 4 - length) * ratio, height: length - (length - width) * ratio)
                                .padding(.top, proxy.size.width / 3)
                                .rotationEffect(Angle(radians: Double(ratio) * .pi / -4), anchor: .bottomLeading)
                                .offset(x: -width * ratio, y: width / length * ratio)
                            */
                            
                            
                                
                            RoundedRectangle(cornerRadius: ratio)
                                .frame(width: proxy.size.width / 2 * ratio, height: 2)
                                .rotationEffect(Angle(radians: Double(.pi / 2 + (.pi / 4 * ratio))))
                        }
                        .foregroundColor(pathColor)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            )
    }
}

#if DEBUG
struct MathSymbolShape_Previews: PreviewProvider {
    
    static var previews: some View {
        let length: CGFloat = 50
        let ratio: CGFloat = 0
        
        let view = ZStack {
            Circle()
               .frame(width: length, height: length)
               .modifier(MathSymbolModifier(ratio: ratio))
                .scaleEffect(10)
        }
        
        .frame(width: 100, height: 60)
        
        Group {
            view
                .previewDevice("iPhone 8")
                .preferredColorScheme(.dark)
        }
    }
}
#endif
