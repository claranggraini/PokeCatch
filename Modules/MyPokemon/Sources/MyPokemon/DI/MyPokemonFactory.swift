@MainActor
enum MyPokemonFactory {
    static func makeMyPokemonView(persistence: MyPokemonPersistenceProtocol) -> MyPokemonView {
        let repository = MyPokemonRepository(persistence: persistence)
        let useCase = MyPokemonUseCase(repository: repository)
        return MyPokemonView(viewModel: MyPokemonViewModel(useCase: useCase))
    }
}
