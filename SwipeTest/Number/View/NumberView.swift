//
//  NumberView.swift
//
//  Created by Den Jo on 2021/05/25.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct NumberView: View {
    
    // MARK: - Value
    // MARK: Private
    private let component: NumberComponent
    private let animation: Animation?
    private let font: Font
    
    @Binding private var size: CGSize
    
    private var offset: CGFloat {
        var digit: CGFloat {
            switch component {
            case .digit(let number):    return CGFloat(number)
            case .nonDigit:             return 0
            }
        }
        
        return -size.height * (4.5 - digit)
    }
    
    
    // MARK: - Initializer
    init(component: NumberComponent, animation: Animation?, font: Font, size: Binding<CGSize>) {
        self.component = component
        self.animation = animation
        self.font      = font
        self._size     = size
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        switch component {
        case .digit:
            VStack(spacing: 0) {
                ForEach((0..<10).reversed(), id: \.self) {
                    Text("\($0)")
                        .font(font)
                        .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width, height: size.height)
            .offset(y: offset)
            .clipped()
            .animation(animation)
            
        case .nonDigit(let string):
            Text(string)
                .font(font)
                .padding([.leading, .trailing], 1)
                .animation(.none)
        }
    }
}
