//
//  PokedexUseCaseProtocol.swift
//  Pokedex
//
//  Created by Clara on 02/10/26.
//
import Foundation

protocol PokedexUseCaseProtocol: Sendable {
    func fetchPokemonList() async throws -> [Pokemon]
}
