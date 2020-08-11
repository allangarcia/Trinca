//
//  Stripes.swift
//  Trinca
//
//  Created by Eneko Alonso on 7/7/20.
//  Adapted by Allan Garcia on 11/08/2020.
//  Copyright © 2020 Allan Garcia. All rights reserved.
//

import SwiftUI

struct Stripes: View {
    
    let width: CGFloat
    let spacing: CGFloat
    let degrees: Double
    
    let foreground: Color
    let background: Color
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
        .clipped()
        .drawingGroup()
    }
    
    private func body(for size: CGSize) -> some View {
        let longSide = max(size.width, size.height)
        let itemWidth = width + spacing
        let items = Int(2 * longSide / itemWidth)
        return HStack(spacing: spacing) {
            ForEach(0..<items) { index in
                self.foreground
                    .frame(width: self.width, height: 2 * longSide)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .rotationEffect(Angle(degrees: degrees), anchor: .center)
        .offset(x: -longSide / 2, y: -longSide / 2)
        .background(background)
    }
    
}
