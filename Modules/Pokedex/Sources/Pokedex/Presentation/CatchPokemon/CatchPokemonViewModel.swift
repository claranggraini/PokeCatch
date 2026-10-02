import SwiftUI

@MainActor
final class CatchPokemonViewModel: ObservableObject {
    @Published private(set) var caughtPokemon: [Pokemon] = []
    @Published private(set) var didCatch = false
    @Published private(set) var hasAttemptedCatch = false
    @Published private(set) var isSaved = false
    @Published private(set) var error: Error?

    private let useCase: CatchPokemonUseCaseProtocol

    init(useCase: CatchPokemonUseCaseProtocol) {
        self.useCase = useCase
    }

    func catchPokemon(_ pokemon: Pokemon, randomBool: Bool) {
        error = nil
        do {
            didCatch = try useCase.catchPokemon(pokemon, randomBool: randomBool)
        } catch {
            didCatch = false
            self.error = error
        }
        hasAttemptedCatch = true
    }

    func saveCaughtPokemon(_ pokemon: Pokemon, nickname: String) {
        guard hasAttemptedCatch && didCatch && !isSaved else { return }
        error = nil
        let trimmedNickname = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        do {
            try useCase.saveCaughtPokemon(
                pokemon,
                nickname: trimmedNickname.isEmpty ? pokemon.name : trimmedNickname
            )
            var caught = pokemon
            caught.wasCaught = true
            caughtPokemon.append(caught)
            isSaved = true
        } catch {
            isSaved = false
            self.error = error
        }
    }
}
