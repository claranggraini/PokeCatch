@MainActor
public protocol PokemonPersistenceProtocol {
    func saveCaughtPokemon(
        pokedexID: Int,
        nickname: String,
        sprite: String,
        height: Int,
        weight: Int,
        types: [String]
    ) throws

    func fetchCaughtPokemonIDs() throws -> [Int]
}
