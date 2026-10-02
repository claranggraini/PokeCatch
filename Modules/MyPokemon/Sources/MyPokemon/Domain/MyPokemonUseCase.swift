@MainActor
protocol MyPokemonUseCaseProtocol {
    func fetchCaughtPokemon() throws -> [MyPokemon]
    func releasePokemon(id: Int) throws
}

@MainActor
final class MyPokemonUseCase: MyPokemonUseCaseProtocol {
    private let repository: MyPokemonRepositoryProtocol

    init(repository: MyPokemonRepositoryProtocol) {
        self.repository = repository
    }

    func fetchCaughtPokemon() throws -> [MyPokemon] {
        try repository.fetchCaughtPokemon()
    }

    func releasePokemon(id: Int) throws {
        try repository.deleteCaughtPokemon(id: id)
    }
}
