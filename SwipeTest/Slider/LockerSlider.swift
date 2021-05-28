// 
//  LockerSlider.swift
//
//  Created by Den Jo on 2021/05/28.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct LockerSlider<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    
    // MARK: - Value
    // MARK: Private
    @Binding private var value: V
    private let bounds: ClosedRange<V>
    private let step: V.Stride
    
    private let length: CGFloat    = 50
    private let lineWidth: CGFloat = 2
    
    @State private var ratio: CGFloat   = 0
    @State private var startX: CGFloat? = nil
        
    
    // MARK: - Initializer
    init(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride) {
        _value  = value
        
        self.bounds = bounds
        self.step   = step
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                // Track
                RoundedRectangle(cornerRadius: length / 2)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                
                // Thumb
                Circle()
                    .foregroundColor(.white)
                    .frame(width: length, height: length)
                    .offset(x: (proxy.size.width - length) * ratio)
                    .gesture(DragGesture(minimumDistance: 0)
                                .onChanged {
                                    guard startX == nil else { return }
                                    
                                    let delta = $0.startLocation.x - (proxy.size.width - length) * ratio
                                    startX = (length < $0.startLocation.x && 0 < delta) ? delta : $0.startLocation.x
                                }
                                .onEnded { _ in
                                    startX = nil
                                })
            }
            .frame(height: length)
            .overlay(overlay)
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                                    .onChanged {
                                        guard let x = startX else { return }
                                        startX = min(length, max(0, x))
                                        
                                        var point = $0.location.x - x
                                        let delta = proxy.size.width - length
                                        
                                        if point < 0 {
                                            startX = $0.location.x
                                            point = 0
                                            
                                        } else if delta < point {
                                            startX = $0.location.x - delta
                                            point = delta
                                        }
                                        
                                        ratio = point / delta
                                        
//                                        let unit = self.in.upperBound / self.step
                                        
                                        value = V(bounds.upperBound) * V(ratio)
                                    })
            .onAppear {
                ratio = min(1, max(0,CGFloat(value / bounds.upperBound)))
            }
        }
    }
    
    // MARK: Private
    private var overlay: some View {
        RoundedRectangle(cornerRadius: (length + lineWidth) / 2)
            .stroke(Color.gray, lineWidth: lineWidth)
            .frame(height: length + lineWidth)
    }
}

#if DEBUG
struct LockerSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = LockerSlider(value: .constant(20), in: 0...10, step: 1)
        
        Group {
            view
                .previewDevice("iPhone 8")
                .preferredColorScheme(.dark)
        }
    }
}
#endif
