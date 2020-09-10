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
        // Limpa todas as cartas que não sao match
        for misMatchedCard in misMatchedCards {
            if let index = cards.firstIndex(matching: misMatchedCard) {
                cards[index].isMatched = nil
            }
        }
        // Ignora quando a carta já foi matched
        if let matched = card.isMatched {
            if matched {
                return
            }
        }
        // Seleciona a carta
        if let index = cards.firstIndex(matching: card) {
            cards[index].isSelected.toggle()
        }
        // Se houver 3 cartas tenta fazer match
        if selectedCards.count == 3 {
            matchSelectedCards()
        }
    }
    
    var misMatchedCards: Array<Card> {
        cards.filter { card in
            guard let isMatchedCard = card.isMatched else {
                return false
            }
            return !isMatchedCard
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
            
            var matchedNumber = false
            var matchedShape = false
            var matchedColor = false
            var matchedTexture = false
            
            // tentar um match com numero
            if card1.number == card2.number && card2.number == card3.number {
                matchedNumber = true
            }
            if card1.number != card2.number && card2.number != card3.number && card3.number != card1.number {
                matchedNumber = true
            }
            
            // tentar um match com forma
            if card1.shape == card2.shape && card2.shape == card3.shape {
                matchedShape = true
            }
            if card1.shape != card2.shape && card2.shape != card3.shape && card3.shape != card1.shape {
                matchedShape = true
            }
            
            // tentar um match com cor
            if card1.color == card2.color && card2.color == card3.color {
                matchedColor = true
            }
            if card1.color != card2.color && card2.color != card3.color && card3.color != card1.color {
                matchedColor = true
            }
            
            // tentar um match com textura
            if card1.texture == card2.texture && card2.texture == card3.texture {
                matchedTexture = true
            }
            if card1.texture != card2.texture && card2.texture != card3.texture && card3.texture != card1.texture {
                matchedTexture = true
            }
            
            if matchedNumber && matchedShape && matchedColor && matchedTexture {
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
