//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Clara on 02/10/26.
//

import SwiftUI
import Networking

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    private let id: Int?
    private let networkClient: NetworkClientProtocol

    init(pokemon: Pokemon? = nil, id: Int?, networkClient: NetworkClientProtocol) {
        self.pokemon = pokemon
        self.id = id
        self.networkClient = networkClient
    }

    func load() async {
        guard let id else { return }

        let result: Result<PokemonResponse, NetworkError> = await networkClient.request(
            to: PokedexEndpoint.getPokemonDetailById(id: id),
            decodeTo: PokemonResponse.self
        )

        if case .success(let response) = result {
            pokemon = PokedexMapper.mapPokemonResponsesToModel(
                input: response,
                caughtPokemonsId: []
            )
        }
    }
}
