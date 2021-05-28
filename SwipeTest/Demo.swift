//
//  Demo.swift
//  SwipeTest
//
//  Created by Den Jo on 2021/05/25.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct Demo: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var number = 150000.0
    
    private let dollar = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue : "USD"]))
    private let euro   = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue : "EUR"]))
    private let won    = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue : "KRW"]))
    
    
    // MARK - View
    // MARK: Public
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            dollars
            separator1

            wons
            separator1
            
            euros
            separator2
            
            sliders
        }
        .padding(20)
    }
    
    // MARK: Private
    private var dollars: some View {
        Group {
            HStack {
                NumberCounterView(number: number, numberStyle: .currency, locale: dollar, font: .system(size: 30, weight: .bold, design: .rounded))
                Spacer()
            }
            
            HStack {
                NumberCounterView(number: number, numberStyle: .currencyPlural, locale: dollar, font: .system(size: 30, weight: .bold, design: .rounded))
                Spacer()
            }
        }
    }
    
    private var wons: some View {
        Group {
            NumberCounterView(number: number, numberStyle: .currency, locale: won, font: .system(size: 30, weight: .bold, design: .rounded))
            
            NumberCounterView(number: number, numberStyle: .currencyPlural, locale: won, font: .system(size: 30, weight: .bold, design: .rounded))
            
            NumberCounterView(number: number, numberStyle: .currency, locale: won, suffix: "원", font: .system(size: 25, weight: .medium, design: .monospaced))
                .foregroundColor(Color(.secondaryLabel))
        }
    }
    
    private var euros: some View {
        Group {
            HStack {
                Spacer()
                NumberCounterView(number: number * 0.84025, numberStyle: .currency, locale: euro, font: .system(size: 25, weight: .medium, design: .serif))
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            HStack {
                Spacer()
                NumberCounterView(number: number * 0.84025, numberStyle: .currencyPlural, locale: euro, font: .system(size: 25, weight: .medium, design: .serif))
                    .foregroundColor(Color(.secondaryLabel))
            }
        }
    }
    
    private var sliders: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Number\n\(number)")
                    .bold()
                
                Spacer()
                
                Stepper(value: $number, in: 0...1050000, step: 0.01) {

                }
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
            
            LockerSlider(value: $number, in: 0...1050000, step: 0.02)
                .padding(.bottom, 20)
        }
    }
    
    private var separator1: some View {
        Color.gray
            .frame(height: 1)
            .padding(.vertical, 20)
    }
    
    private var separator2: some View {
        Color.purple
            .frame(height: 3)
            .padding(.vertical, 20)
    }
}
