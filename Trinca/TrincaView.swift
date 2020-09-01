//
//  TrincaView.swift
//  Trinca
//
//  Created by Allan Garcia on 09/08/2020.
//  Copyright © 2020 Allan Garcia. All rights reserved.
//

import SwiftUI

struct TrincaView: View {
    
    var trinca: TrincaViewModel
    
    var body: some View {
        Grid(trinca.tableCards) { card in
            CardView(card: card)
        }
    .padding()
    }
    
}

struct CardView: View {
    
    var card: TrincaBrain.Card
    
    var number: Int {
        switch card.number {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        }
    }
    
    var color: Color {
        switch card.color {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        }
    }
    
    var body: some View {
        Group {
            VStack {
                ForEach(0..<number) { _ in
                    ShapeView(
                        shape: self.card.shape,
                        texture: self.card.texture
                    )
                    .aspectRatio(2/1, contentMode: .fit)
                }
            }
            .padding()
        }
        .foregroundColor(color)
        .cardify(isFaceUp: true)
        .padding(5)
    }
    
}

struct ShapeView: View {
    
    var shape: TrincaBrain.Card.Shape
    var texture: TrincaBrain.Card.Texture
    
    var body: some View {
        Group {
            if shape == .diamond {
                DiamondShape()
                    .cardTexture(texture: texture)
            } else if shape == .oval {
                OvalShape()
                    .cardTexture(texture: texture)
            } else if shape == .squiggle {
                SquiggleShape()
                    .cardTexture(texture: texture)
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let trinca = TrincaViewModel()
        return TrincaView(trinca: trinca)
    }
}
