//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Clara on 02/10/26.
//

import SwiftUI

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    init(pokemon: Pokemon? = nil) {
        self.pokemon = pokemon
    }
}
