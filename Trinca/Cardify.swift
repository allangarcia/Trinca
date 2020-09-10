//
//  Cardify.swift
//  Memorize
//
//  Created by Allan Garcia on 06/08/2020.
//  Copyright © 2020 Allan Garcia. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var rotation: Double
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var isSelected: Bool = false
    
//    init(isFaceUp: Bool) {
//        self.rotation = isFaceUp ? 0 : 180
//    }
    
    init(isSelected: Bool) {
        self.rotation = 0
        self.isSelected = isSelected
    }
    
    var animatableData: Double {
        get {
            return rotation
        }
        set {
            rotation = newValue
        }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(edgeColor, lineWidth: edgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.8),Color.accentColor.opacity(0.2)]),startPoint: .top, endPoint: .bottom))
            }
            .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    
    private let cornerRadius: CGFloat = 10
    private var edgeLineWidth: CGFloat {
        isSelected ? 5 : 3
    }
    private var edgeColor: Color {
        isSelected ? Color.blue : Color.black
    }
    
}

extension View {
//    func cardify(isFaceUp: Bool) -> some View {
//        self.modifier(Cardify(isFaceUp: isFaceUp))
//    }
    
    func cardify(isSelected: Bool) -> some View {
        self.modifier(Cardify(isSelected: isSelected))
    }
}
