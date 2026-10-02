@MainActor
final class MyPokemonRepository: MyPokemonRepositoryProtocol {
    private let persistence: MyPokemonPersistenceProtocol

    init(persistence: MyPokemonPersistenceProtocol) {
        self.persistence = persistence
    }

    func fetchCaughtPokemon() throws -> [MyPokemon] {
        try persistence.fetchCaughtPokemon()
    }

    func deleteCaughtPokemon(id: Int) throws {
        try persistence.deleteCaughtPokemon(id: id)
    }
}
