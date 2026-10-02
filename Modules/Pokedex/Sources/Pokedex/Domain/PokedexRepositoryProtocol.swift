//
//  PokedexRepositoryProtocol.swift
//  Pokedex
//
//  Created by Clara on 01/10/26.
//
import Networking

protocol PokedexRepositoryProtocol: Sendable {
    func fetchPokemonList() async -> Result<[PokemonList], NetworkError>
    func fetchPokemonDetail(from pokemonList: [PokemonList]) async -> Result<[Pokemon], NetworkError>
    func fetchPokemonDetail(id: Int) async -> Result<Pokemon, NetworkError>
    func fetchCaughtPokemonIds() -> [Int]
}
