//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Clara on 01/10/26.
//

import SwiftUI

public struct PokemonDetailView: View {
    let id: String
    public var body: some View {
        VStack {
            Text("Detail for \(id)")
        }
    }
}
