//
//  MyPokemonViewModel.swift
//  MyPokemon
//
//  Created by Clara on 02/10/26.
//
import Combine
import Foundation

@MainActor
final class MyPokemonViewModel: ObservableObject {
    @Published private(set) var myPokemonList: [MyPokemon] = []
    @Published private(set) var releasedPokemonName: String?
    @Published private(set) var error: Error?

    private let useCase: MyPokemonUseCaseProtocol

    init(useCase: MyPokemonUseCaseProtocol) {
        self.useCase = useCase
    }

    func load() {
        do {
            myPokemonList = try useCase.fetchCaughtPokemon()
            error = nil
        } catch {
            self.error = error
        }
    }

    func release(_ pokemon: MyPokemon) {
        do {
            try useCase.releasePokemon(id: pokemon.id)
            myPokemonList.removeAll { $0.id == pokemon.id }
            releasedPokemonName = pokemon.name
            error = nil
        } catch {
            self.error = error
        }
    }

    func clearToast() {
        releasedPokemonName = nil
    }

    func clearError() {
        error = nil
    }
}
