@MainActor
protocol CatchPokemonRepositoryProtocol {
    func catchPokemon(_ pokemon: Pokemon, randomBool: Bool) throws -> Bool
    func saveCaughtPokemon(_ pokemon: Pokemon, nickname: String) throws
}
