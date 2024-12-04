//
//  ColourFullBorder.swift
//  PlanetsJPM
//
//  Created by Dionisis Chatzimarkakis on 18/11/24.
//

import SwiftUI

struct ColourfulBorder: ViewModifier {
    
    var colors: [Color]
    var lineWidth: CGFloat
    
    @State private var gradientStart: UnitPoint = .leading
    @State private var gradientEnd: UnitPoint = .trailing
    
    func body(content: Content) -> some View {
        content
            .padding(lineWidth)
            .background(
                LinearGradient(gradient: Gradient(colors: colors),
                               startPoint: gradientStart,
                               endPoint: gradientEnd)
                .mask(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: lineWidth)
                )
            )
    }
    
}

extension View {
    
    func colourfulBorder(colors: [Color],
                         lineWidth: CGFloat = 2) -> some View {
        
        self.modifier(ColourfulBorder(colors: colors,
                                      lineWidth: lineWidth))
    }
    
}
