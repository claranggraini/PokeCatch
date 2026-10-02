//
//  PokedexRepository.swift
//  Pokedex
//
//  Created by Clara on 01/10/26.
//

import Networking

final class PokedexRepository: PokedexRepositoryProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func fetchPokemonList() async -> Result<[PokemonList], NetworkError> {
        let result: Result<PokemonListResponse, NetworkError> = await networkClient.request(
            to: PokedexEndpoint.getPokemons,
            decodeTo: PokemonListResponse.self
        )
        
        switch result {
        case .success(let response):
            return .success(PokedexMapper.mapPokemonListResponsesToModel(input: response))
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func fetchPokemonDetail(from pokemonList: [PokemonList]) async -> Result<[Pokemon], NetworkError> {
        var pokemonDetailList: [Pokemon] = []
        for pokemon in pokemonList {
            let result: Result<PokemonResponse, NetworkError> = await networkClient.request(
                to: PokedexEndpoint.getPokemonDetail(name: pokemon.name),
                decodeTo: PokemonResponse.self
            )
            
            switch result {
            case .success(let response):
                pokemonDetailList.append(PokedexMapper.mapPokemonResponsesToModel(input: response, caughtPokemonsId: fetchCaughtPokemonIds()))
                
            case .failure(let error):
                return .failure(error)
            }
        }
        return .success(pokemonDetailList)
    }

    func fetchPokemonDetail(id: Int) async -> Result<Pokemon, NetworkError> {
        let result: Result<PokemonResponse, NetworkError> = await networkClient.request(
            to: PokedexEndpoint.getPokemonDetailById(id: id),
            decodeTo: PokemonResponse.self
        )

        switch result {
        case .success(let response):
            return .success(
                PokedexMapper.mapPokemonResponsesToModel(
                    input: response,
                    caughtPokemonsId: fetchCaughtPokemonIds()
                )
            )
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func fetchCaughtPokemonIds() -> [Int] {
        return []
    }
}
