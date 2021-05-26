//
//  NumberDemo.swift
//  SwipeTest
//
//  Created by Den Jo on 2021/05/25.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct NumberDemo: View {
    // MARK: - Value
    // MARK: Private
    @State private var number = 150000.0
    
    private let dollar = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue : "USD"]))
    private let euro   = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue : "EUR"]))
    private let won    = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue : "KRW"]))
    
    
    // MARK - View
    // MARK: Public
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Dollar
            Group {
                NumberCounterView(number: number, numberStyle: .currency, locale: dollar, font: .system(size: 30, weight: .bold, design: .rounded))
                    
                NumberCounterView(number: number, numberStyle: .currencyPlural, locale: dollar, font: .system(size: 30, weight: .bold, design: .rounded))
                    .padding(.bottom, 40)
            }
            
            Color.gray
                .frame(height: 2)
            
            
            // Euro
            Group {
                NumberCounterView(number: number * 0.84025, numberStyle: .currency, locale: euro, font: .system(size: 25, weight: .medium, design: .serif))
                    .foregroundColor(Color(.secondaryLabel))
                    
                NumberCounterView(number: number * 0.84025, numberStyle: .currencyPlural, locale: euro, font: .system(size: 25, weight: .medium, design: .serif))
                    .foregroundColor(Color(.secondaryLabel))
                    .padding(.bottom, 40)
            }
            
            Color.gray
                .frame(height: 2)
            
            
            // Won
            Group {
                NumberCounterView(number: number, numberStyle: .currency, locale: won, font: .system(size: 30, weight: .bold, design: .rounded))
                    
                NumberCounterView(number: number, numberStyle: .currencyPlural, locale: won, font: .system(size: 30, weight: .bold, design: .rounded))
                    
                NumberCounterView(number: number, numberStyle: .currency, locale: won, suffix: "원", font: .system(size: 25, weight: .medium, design: .monospaced))
                    .foregroundColor(Color(.secondaryLabel))
                    .padding(.bottom, 40)
            }
            
            Color.purple
                .frame(height: 2)
            
            
            HStack {
                Text("Number\n\(number)")
                    .bold()
                
                Spacer()
                
                Stepper(value: $number, in: 0...1050000, step: 1) {
                    
                }
            }
            .padding(.bottom, 30)
            
            Slider(value: $number, in: 0...1050000, step: 0.01)
        }
        .padding(25)
    }
}
