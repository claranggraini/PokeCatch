@MainActor
public protocol MyPokemonPersistenceProtocol {
    func fetchCaughtPokemon() throws -> [MyPokemon]
    func deleteCaughtPokemon(id: Int) throws
}
