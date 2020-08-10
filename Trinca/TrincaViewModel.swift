//
//  TrincaViewModel.swift
//  Trinca
//
//  Created by Allan Garcia on 10/08/2020.
//  Copyright © 2020 Allan Garcia. All rights reserved.
//

import SwiftUI

class TrincaViewModel {
    
    var brain: TrincaBrain
    
    init() {
        brain = TrincaBrain()
    }
    
    // MARK: - Acesso ao modelo
    
    /**
    Esta função retorna as próximas 12 cartas do desk ou
    as últimas cartas caso o deck seja menor do que 12 cartas.
    */
    var tableCards: Array<TrincaBrain.Card> {
        let size = cards.count
        let maxCards = 12
        let sliceTableCards = cards[0..<min(maxCards,size)]
        let tableCards = Array(sliceTableCards)
        return tableCards
    }
    
    var cards: Array<TrincaBrain.Card> {
        brain.cards
    }
    
    // MARK: - Intenções / Intents
    
}
