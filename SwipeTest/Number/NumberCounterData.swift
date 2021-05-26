//
//  NumberComponentManager.swift
//
//  Created by Den Jo on 2021/05/25.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

final class NumberCounterData {
    
    // MARK: - Value
    // MARK: Public
    let suffix: String
    let font: Font
    let components: [NumberComponent]
    
    
    // MARK: - Initializer
    init(number: Double, numberStyle: NumberFormatter.Style, locale: Locale, suffix: String, font: Font) {
        self.suffix = suffix
        self.font   = font
        
        // Component
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = numberStyle
        numberFormatter.locale      = locale
        
        guard let formattedString = numberFormatter.string(for: number) else {
            components = []
            return
        }
        
        components = formattedString.compactMap {
            guard let digit = $0.wholeNumberValue else { return .nonDigit(String($0)) }
            return .digit(digit)
        }
    }
}
