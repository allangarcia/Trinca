//
//  Shape+Texture.swift
//  Trinca
//
//  Created by Allan Garcia on 01/09/2020.
//  Copyright © 2020 Allan Garcia. All rights reserved.
//

import SwiftUI

extension Shape {
    func cardTexture(texture: TrincaBrain.Card.Texture) -> some View {
        Group {
            if texture == .open {
                self.stroke(lineWidth: 2)
            } else if texture == .solid {
                ZStack {
                    self.fill()
                    self.stroke(lineWidth: 2)
                }
            } else if texture == .stripped {
                ZStack {
                    self.overlay(
                        Stripes(width: 5, spacing: 2, degrees: 30, foreground: Color.white, background: Color.clear)
                    )
                    self.stroke(lineWidth: 2)
                }
            }
        }
    }
}
