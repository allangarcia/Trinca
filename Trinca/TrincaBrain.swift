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
    
    struct Card {
        var number: Number
        var shape: Shape
        var color: Color
        var texture: Texture
        
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

    
    var cards: Array<Card> = TrincaBrain.makeDeck()
    
    static func makeDeck() -> Array<Card> {
        
        var result = Array<Card>()
        
        for number in Card.Number.allCases {
            for shape in Card.Shape.allCases {
                for color in Card.Color.allCases {
                    for texture in Card.Texture.allCases {
                        result.append(Card(number: number, shape: shape, color: color, texture: texture))
                    }
                }
            }
        }
        
        return result
        
    }
    
    
}
