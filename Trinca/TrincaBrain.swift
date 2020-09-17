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
        cleanMismatchedCards()
        
        // Ignora quando a carta já foi matched
        if let matched = card.isMatched, matched { return }
        
        // Subistitui cards the foram feito set por novas do deck
        replaceMatchedCards()
        
        // Seleciona a carta
        if let index = tableCards.firstIndex(matching: card) {
            tableCards[index].isSelected.toggle()
        }
        
        // Se houver 3 cartas tenta fazer match
        if selectedCards.count == 3 {
            matchSelectedCards()
        }
    }
    
    private mutating func cleanMismatchedCards() {
        for mismatchedCard in mismatchedCards {
            if let index = tableCards.firstIndex(matching: mismatchedCard) {
                tableCards[index].isMatched = nil
            }
        }
    }
    
    private var mismatchedCards: Array<Card> {
        tableCards.filter { card in
            guard let isMatchedCard = card.isMatched else {
                return false
            }
            return !isMatchedCard
        }
    }
    
    private mutating func replaceMatchedCards() {
        for matchedCard in matchedCards {
            if let i = tableCards.firstIndex(matching: matchedCard) {
                let card = tableCards[i]
                tableCards.remove(at: i)
                discardedCards.append(card)
                if let newCard = deckCards.popLast() {
                    tableCards.insert(newCard, at: i)
                }
            }
        }
    }
    
    private var matchedCards: Array<Card> {
        tableCards.filter { card in
            guard let isMatchedCard = card.isMatched else {
                return false
            }
            return isMatchedCard
        }
    }
    
    var selectedCards: Array<Card> {
        tableCards.filter { card in
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
            
            if let index = tableCards.firstIndex(matching: card1) {
                tableCards[index].isMatched = matched
                tableCards[index].isSelected = false
            }
            if let index = tableCards.firstIndex(matching: card2) {
                tableCards[index].isMatched = matched
                tableCards[index].isSelected = false
            }
            if let index = tableCards.firstIndex(matching: card3) {
                tableCards[index].isMatched = matched
                tableCards[index].isSelected = false
            }
            
        }
        
    }
    
    private var cards: Array<Card> = TrincaBrain.makeCards()
    
    private(set) var deckCards: Array<Card> = []
    private(set) var tableCards: Array<Card> = []
    private(set) var discardedCards: Array<Card> = []
    
    mutating func loadDeck() {
        deckCards = cards.shuffled()
    }
    
    mutating func dealThree() {
        if matchedCards.count == 3 {
            replaceMatchedCards()
        } else {
            dealCards(count: 3)
        }
    }
    
    private mutating func dealCards(count: Int) {
        for _ in 0..<count {
            if let card = deckCards.popLast() {
                tableCards.append(card)
            }
        }
    }
    
    init() {
        self.loadDeck()
        self.initialDeal()
    }
    
    mutating func initialDeal() {
        dealCards(count: 12)
    }
    
    static func makeCards() -> Array<Card> {
        
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
        
        return result
        
    }
    
    
}
