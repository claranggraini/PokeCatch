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
    private let id: Int?
    private let useCase: PokedexUseCaseProtocol

    init(pokemon: Pokemon? = nil, id: Int?, useCase: PokedexUseCaseProtocol) {
        self.pokemon = pokemon
        self.id = id
        self.useCase = useCase
    }

    func load() async {
        guard let id else { return }

        do {
            pokemon = try await useCase.fetchPokemonDetail(id: id)
        } catch {
            pokemon = nil
        }
    }
}
