import Testing
@testable import Pokedex

@MainActor
@Test func catchRequiresSuccessAndNicknameConfirmation() throws {
    let persistence = RecordingPokemonPersistence()
    let repository = CatchPokemonRepository(persistence: persistence)
    let useCase = CatchPokemonUseCase(repository: repository)
    let viewModel = CatchPokemonViewModel(useCase: useCase)
    let pokemon = Pokemon(id: 25, name: "pikachu", sprite: "sprite", stats: [], moves: [], types: [], height: 4, weight: 60, wasCaught: false)

    viewModel.catchPokemon(pokemon, randomBool: false)
    viewModel.saveCaughtPokemon(pokemon, nickname: "Ignored")
    #expect(persistence.savedNames.isEmpty)
    #expect(viewModel.caughtPokemon.isEmpty)

    viewModel.catchPokemon(pokemon, randomBool: true)
    #expect(persistence.savedNames.isEmpty)
    viewModel.saveCaughtPokemon(pokemon, nickname: "  ")
    #expect(persistence.savedNames == ["pikachu"])
    #expect(viewModel.caughtPokemon.count == 1)
    #expect(viewModel.caughtPokemon.first?.wasCaught == true)
    viewModel.saveCaughtPokemon(pokemon, nickname: "Another")
    #expect(persistence.savedNames.count == 1)
}

@MainActor
@Test func nicknameIsTrimmedBeforeSaving() {
    let persistence = RecordingPokemonPersistence()
    let viewModel = CatchPokemonViewModel(useCase: CatchPokemonUseCase(repository: CatchPokemonRepository(persistence: persistence)))
    let pokemon = Pokemon(id: 25, name: "pikachu", sprite: "", stats: [], moves: [], types: [], height: 4, weight: 60, wasCaught: false)

    viewModel.catchPokemon(pokemon, randomBool: true)
    viewModel.saveCaughtPokemon(pokemon, nickname: "  Sparky  ")

    #expect(persistence.savedNames == ["Sparky"])
}

@MainActor
private final class RecordingPokemonPersistence: PokemonPersistenceProtocol {
    var savedNames: [String] = []

    func saveCaughtPokemon(pokedexID: Int, nickname: String, sprite: String, height: Int, weight: Int, types: [String]) throws {
        savedNames.append(nickname)
    }

    func fetchCaughtPokemonIDs() throws -> [Int] { [] }
}
