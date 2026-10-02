@MainActor
protocol MyPokemonRepositoryProtocol {
    func fetchCaughtPokemon() throws -> [MyPokemon]
    func deleteCaughtPokemon(id: Int) throws
}
