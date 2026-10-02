import Foundation
import Pokedex

@MainActor
struct CoreDataPokemonPersistence: PokemonPersistenceProtocol {
    let controller: PersistenceController

    func saveCaughtPokemon(
        pokedexID: Int,
        nickname: String,
        sprite: String,
        height: Int,
        weight: Int,
        types: [String]
    ) throws {
        try controller.insertCaughtPokemon(
            pokedexID: Int32(pokedexID),
            nickname: nickname,
            sprite: sprite,
            height: Int32(height),
            weight: Int32(weight),
            color: nil,
            pokemonType: types
        )
    }

    func fetchCaughtPokemonIDs() throws -> [Int] {
        try controller.fetchPokemonEntities().map { Int($0.pokedexID) }
    }
}
