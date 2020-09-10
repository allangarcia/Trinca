//
//  TrincaBrain.swift
//  Trinca
//
//  Created by Allan Garcia on 09/08/2020.
//  Copyright © 2020 Allan Garcia. All rights reserved.
//

import Foundation

// 81 cartas
// 4 caracteristicas
// 3 variedades de cada



struct TrincaBrain {
    
    struct Card: Identifiable {
        var id: Int
        var number: Number
        var shape: Shape
        var color: Color
        var texture: Texture
        
        var isSelected: Bool = false
        var isMatched: Bool?
        
        enum Number: CaseIterable {
            case one, two, three
        }
        
        enum Shape: CaseIterable {
            case diamond, squiggle, oval
        }
        
        enum Color: CaseIterable {
            case red, green, purple
        }
        
        enum Texture: CaseIterable {
            case open, solid, stripped
        }
        
    }
    
    mutating func toggleCard(_ card: Card) {
        if let index = cards.firstIndex(matching: card) {
            cards[index].isSelected.toggle()
        }
        if selectedCards.count == 3 {
            matchSelectedCards()
        }
    }
    
    var selectedCards: Array<Card> {
        cards.filter { card in
            card.isSelected
        }
    }
    
    private mutating func matchSelectedCards() {
        /*
         Para cada uma das caracteristicas (numero, forma, cor, e textura)
         Testar se a caracteristica das tres cartas são todas iguais ou todas diferentes
         */
        print("Matching cards...")
        
        var matched = false
        
        if selectedCards.count == 3 {
            let card1 = selectedCards[0]
            let card2 = selectedCards[1]
            let card3 = selectedCards[2]
            
            // tentar um match com numero
            if card1.number == card2.number && card2.number == card3.number {
                matched = true
            }
            if card1.number != card2.number && card2.number != card3.number && card3.number != card1.number {
                matched = true
            }
            
            // tentar um match com forma
            if card1.shape == card2.shape && card2.shape == card3.shape {
                matched = true
            }
            if card1.shape != card2.shape && card2.shape != card3.shape && card3.shape != card1.shape {
                matched = true
            }
            
            // tentar um match com cor
            if card1.color == card2.color && card2.color == card3.color {
                matched = true
            }
            if card1.color != card2.color && card2.color != card3.color && card3.color != card1.color {
                matched = true
            }
            
            // tentar um match com textura
            if card1.texture == card2.texture && card2.texture == card3.texture {
                matched = true
            }
            if card1.texture != card2.texture && card2.texture != card3.texture && card3.texture != card1.texture {
                matched = true
            }
            
            // Mudando o estado da carta matched ou nao-matched
            
            if let index = cards.firstIndex(matching: card1) {
                cards[index].isMatched = matched
                cards[index].isSelected = false
            }
            if let index = cards.firstIndex(matching: card2) {
                cards[index].isMatched = matched
                cards[index].isSelected = false
            }
            if let index = cards.firstIndex(matching: card3) {
                cards[index].isMatched = matched
                cards[index].isSelected = false
            }
            
        }
        
    }
    
    private(set) var cards: Array<Card> = TrincaBrain.makeDeck()
    
    static func makeDeck() -> Array<Card> {
        
        var result = Array<Card>()
        var id = 0
        
        for number in Card.Number.allCases {
            for shape in Card.Shape.allCases {
                for color in Card.Color.allCases {
                    for texture in Card.Texture.allCases {
                        result.append(Card(id: id, number: number, shape: shape, color: color, texture: texture))
                        id += 1
                    }
                }
            }
        }
        
        return result.shuffled()
        
    }
    
    
}
