//
//  PokedexUseCase.swift
//  Pokedex
//
//  Created by Clara on 02/10/26.
//

final class PokedexUseCase: PokedexUseCaseProtocol {
    private let repository: PokedexRepositoryProtocol

    init(repository: PokedexRepositoryProtocol) {
        self.repository = repository
    }

    func fetchPokemonList() async throws -> [Pokemon] {
        let result = await repository.fetchPokemonList()
        switch result {
        case .success(let response):
            let pokemonDetailResult = await repository.fetchPokemonDetail(from: response)
            switch pokemonDetailResult {
            case .success(let success):
                return success
            case .failure(let failure):
                throw failure
            }
        case .failure(let error):
            throw error
        }
    }
}
