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
            Text("Carta: \(card.id)")
        }
    }
    
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let trinca = TrincaViewModel()
        return TrincaView(trinca: trinca)
    }
}
