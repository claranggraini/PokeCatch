@MainActor
final class CatchPokemonRepository: CatchPokemonRepositoryProtocol {
    private let persistence: PokemonPersistenceProtocol

    init(persistence: PokemonPersistenceProtocol) {
        self.persistence = persistence
    }

    func catchPokemon(_ pokemon: Pokemon, randomBool: Bool) throws -> Bool {
        guard randomBool else { return false }

        return true
    }

    func saveCaughtPokemon(_ pokemon: Pokemon, nickname: String) throws {
        try persistence.saveCaughtPokemon(
            pokedexID: pokemon.id,
            nickname: nickname,
            sprite: pokemon.sprite,
            height: pokemon.height,
            weight: pokemon.weight,
            types: pokemon.types.map(\.name)
        )
    }
}
