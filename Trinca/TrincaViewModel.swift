//
//  TrincaViewModel.swift
//  Trinca
//
//  Created by Allan Garcia on 10/08/2020.
//  Copyright © 2020 Allan Garcia. All rights reserved.
//

import SwiftUI

class TrincaViewModel: ObservableObject {
    
    @Published var brain: TrincaBrain
    
    init() {
        brain = TrincaBrain()
    }
    
    // MARK: - Acesso ao modelo
    
    /**
    Esta função retorna as próximas 12 cartas do desk ou
    as últimas cartas caso o deck seja menor do que 12 cartas.
    */
    var tableCards: Array<TrincaBrain.Card> {
        brain.tableCards
    }
    
    var deckCards: Array<TrincaBrain.Card> {
        brain.deckCards
    }
    
    // MARK: - Intenções / Intents
    
    func toggleCard(_ card: TrincaBrain.Card) {
        brain.toggleCard(card)
    }
    
    func dealThree() {
        brain.dealThree()
    }
    
    func newGame() {
        brain = TrincaBrain()
    }
    
}
