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
        StripedPattern(width: width, spacing: spacing, degrees: degrees)
            .fill(foreground)
            .background(background)
            .clipped()
            .drawingGroup()
    }
    
}

struct StripedPattern: Shape {
    
    let width: CGFloat
    let spacing: CGFloat
    let degrees: Double
    
    func path(in rect: CGRect) -> Path {
        let longSide = max(rect.width, rect.height)
        let itemWidth = width + spacing
        let numberOfItens = Int(longSide / itemWidth)
        let angle = Angle.degrees(degrees)
        
        var p = Path()
        
        for i in 0...numberOfItens {
            p.addRect(CGRect(x: spacing / 2 + CGFloat(i) * itemWidth,
                             y: 0,
                             width: width,
                             height: longSide))
        }
        let rotate = CGAffineTransform(rotationAngle: CGFloat(angle.radians))
        p = p.applying(rotate)
        
        let bounds = p.boundingRect
        let offsetX = (rect.minX - bounds.minX) - (bounds.width - rect.width) / 2
        let offsetY = (rect.minY - bounds.minY) - (bounds.height - rect.height) / 2
        p = p.offsetBy(dx: offsetX, dy: offsetY)
        
        return p
    }
    
}
