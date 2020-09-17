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
    
    var deckCards: Array<TrincaBrain.Card> {
        brain.deckCards
    }
    
    var tableCards: Array<TrincaBrain.Card> {
        brain.tableCards
    }
    
    // MARK: - Intenções / Intents
    
    func newGame() {
        brain = TrincaBrain()
    }
    
    func toggleCard(_ card: TrincaBrain.Card) {
        brain.toggleCard(card)
    }
    
    func dealThree() {
        brain.dealThree()
    }
    
}
