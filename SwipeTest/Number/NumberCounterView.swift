//
//  NumberCounterView.swift
//
//  Created by Den Jo on 2021/05/25.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct NumberCounterView: View {
    
    // MARK: - Value
    // MARK: Private
    private let data: NumberCounterData
    
    @State private var isAppeared = false
    @State private var size: CGSize = .zero
    
    private var animation: Animation? {
        isAppeared ? Animation.interpolatingSpring(stiffness: 8, damping: 8, initialVelocity: 2).speed(6) : nil
    }
    
    
    // MARK: - Initializer
    init(number: Double, numberStyle: NumberFormatter.Style = .none, locale: Locale = .autoupdatingCurrent, suffix: String = "", font: Font = .system(.body)) {
        data = NumberCounterData(number: number, numberStyle: numberStyle, locale: locale, suffix: suffix, font: font)
    }

    
    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<data.components.count, id: \.self) { i in
                HStack(spacing: 0) {
                    NumberView(component: data.components[i], animation: animation, font: data.font, size: $size)
                }
            }
            
            if !data.suffix.isEmpty {
                Text(data.suffix)
                    .font(data.font)
                    .padding(.leading, 2)
                    .animation(.none)
            }
        }
        .overlay(overlay)
        .animation(animation)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isAppeared = true
            }
        }
    }
    
    // MARK: Private
    private var overlay: some View {
        Text("0")
            .font(data.font)
            .frame {
                size = $0.size  // Update the character size
            }
            .hidden()
    }
}
