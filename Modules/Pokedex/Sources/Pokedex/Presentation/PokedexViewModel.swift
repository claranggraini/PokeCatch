//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by Clara on 02/10/26.
//

import SwiftUI

@MainActor
final class PokedexViewModel: ObservableObject {

    @Published private(set) var pokemonList: [Pokemon] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?

    private let useCase: PokedexUseCaseProtocol

    init(useCase: PokedexUseCaseProtocol) {
        self.useCase = useCase
    }

    func loadPokemonList() async {
        isLoading = true
        error = nil

        do {
            pokemonList = try await useCase.fetchPokemonList()
        } catch {
            self.error = error
        }
        print(pokemonList)
        isLoading = false
    }
}
