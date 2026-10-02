@MainActor
final class CatchPokemonUseCase: CatchPokemonUseCaseProtocol {
    private let repository: CatchPokemonRepositoryProtocol

    init(repository: CatchPokemonRepositoryProtocol) {
        self.repository = repository
    }

    func catchPokemon(_ pokemon: Pokemon, randomBool: Bool) throws -> Bool {
        try repository.catchPokemon(pokemon, randomBool: randomBool)
    }

    func saveCaughtPokemon(_ pokemon: Pokemon, nickname: String) throws {
        try repository.saveCaughtPokemon(pokemon, nickname: nickname)
    }
}
