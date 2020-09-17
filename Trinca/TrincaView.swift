//
//  TrincaView.swift
//  Trinca
//
//  Created by Allan Garcia on 09/08/2020.
//  Copyright © 2020 Allan Garcia. All rights reserved.
//

import SwiftUI

struct TrincaView: View {
    
    @ObservedObject var trinca: TrincaViewModel
    
    var body: some View {
        VStack {
            HStack {
                DeckView(deckOfCards: trinca.deckCards)
                    .frame(width: 80, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                VStack {
                    Button(action: { trinca.newGame() }) {
                        Text("NEW GAME")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(minWidth: 250)
                            .background(Color.green)
                            .cornerRadius(15)
                    }
                    Button(action: { trinca.dealThree() }) {
                        Text("DEAL THREE MORE CARDS")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(minWidth: 250)
                            .background(Color.orange)
                            .cornerRadius(15)
                    }
                }
            }
            .padding()
            Grid(trinca.tableCards) { card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        self.trinca.toggleCard(card)
                    }
            }
        }
        .padding()
    }
    
}


struct DeckView: View {
    
    var deckOfCards: Array<TrincaBrain.Card>

    var body: some View {
        ZStack {
            ForEach(Array(zip(deckOfCards.indices, deckOfCards)), id: \.0) { indice, card in
                let offset = CGFloat(-CGFloat(indice)/CGFloat(5))
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .offset(x: offset, y: offset)
            }
        }
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
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(edgeColor, lineWidth: edgeLineWidth)
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
            .foregroundColor(color)
        }
        .padding(5)
    }
    
    // MARK: - CardView helpers
    
    private var edgeLineWidth: CGFloat {
        if let _ = card.isMatched {
            return 5
        } else {
            if card.isSelected {
                return 5
            } else {
                return 3
            }
        }
    }
    
    private var edgeColor: Color {
        if let matched = card.isMatched {
            if matched {
                return Color.green
            } else {
                return Color.red
            }
        } else {
            if card.isSelected {
                return Color.blue
            } else {
                return Color.black
            }
        }
    }
    
    // MARK: - CardView constants
    
    private let cornerRadius: CGFloat = 10
    
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
        trinca.toggleCard(trinca.tableCards.first!)
        trinca.toggleCard(trinca.tableCards[5])
        return TrincaView(trinca: trinca)
    }
}
