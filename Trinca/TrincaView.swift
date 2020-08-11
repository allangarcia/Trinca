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
            SetCardView(card: card)
        }
    .padding()
    }
    
}

struct SetCardView: View {
    
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
                Spacer()
                ForEach(0..<number) { _ in
                    if self.card.shape == TrincaBrain.Card.Shape.diamond {
                        if self.card.texture == TrincaBrain.Card.Texture.open {
                            Rectangle().stroke()
                        } else if self.card.texture == TrincaBrain.Card.Texture.solid {
                            Rectangle().fill()
                        } else if self.card.texture == TrincaBrain.Card.Texture.stripped {
                            Rectangle()
                                .overlay(
                                    Stripes(width: 2, spacing: 5, degrees: 30, foreground: Color.white, background: Color.clear)
                            )
                        }
                    } else if self.card.shape == TrincaBrain.Card.Shape.oval {
                        if self.card.texture == TrincaBrain.Card.Texture.open {
                            Capsule().stroke()
                        } else if self.card.texture == TrincaBrain.Card.Texture.solid {
                            Capsule().fill()
                        } else if self.card.texture == TrincaBrain.Card.Texture.stripped {
                            Capsule()
                                .overlay(
                                    Stripes(width: 2, spacing: 5, degrees: 30, foreground: Color.white, background: Color.clear)
                            )
                        }
                    } else if self.card.shape == TrincaBrain.Card.Shape.squiggle {
                        if self.card.texture == TrincaBrain.Card.Texture.open {
                            Ellipse().stroke()
                        } else if self.card.texture == TrincaBrain.Card.Texture.solid {
                            Ellipse().fill()
                        } else if self.card.texture == TrincaBrain.Card.Texture.stripped {
                            Ellipse()
                                .overlay(
                                    Stripes(width: 2, spacing: 5, degrees: 30, foreground: Color.white, background: Color.clear)
                            )
                        }
                    } else {
                        Text("Carta: \(self.card.id)")
                    }
                }
                Spacer()
            }
            .padding()
        }
        .foregroundColor(color)
        .cardify(isFaceUp: true)
        .padding(5)
    }
    
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let trinca = TrincaViewModel()
        return TrincaView(trinca: trinca)
    }
}
