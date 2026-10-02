import Networking

@MainActor
enum PokedexFactory {
    static func makeUseCase(networkClient: NetworkClientProtocol) -> PokedexUseCaseProtocol {
        let repository = PokedexRepository(networkClient: networkClient)
        return PokedexUseCase(repository: repository)
    }

    static func makeViewModel(networkClient: NetworkClientProtocol) -> PokedexViewModel {
        PokedexViewModel(useCase: makeUseCase(networkClient: networkClient))
    }

    static func makePokedexView(networkClient: NetworkClientProtocol) -> PokedexView {
        PokedexView(viewModel: makeViewModel(networkClient: networkClient))
    }
    
    static func makePokemonDetailView(
        pokemon: Pokemon?,
        id: Int?,
        networkClient: NetworkClientProtocol,
        coordinator: PokedexCoordinator
    ) -> PokemonDetailView {
        PokemonDetailView(
            viewModel: PokemonDetailViewModel(
                pokemon: pokemon,
                id: id,
                useCase: makeUseCase(networkClient: networkClient)
            ),
            coordinator: coordinator
        )
    }

    static func makeCatchPokemonView(
        pokemon: Pokemon,
        persistence: PokemonPersistenceProtocol,
        coordinator: PokedexCoordinator
    ) -> CatchPokemonView {
        CatchPokemonView(
            pokemon: pokemon,
            viewModel: makeCatchPokemonViewModel(persistence: persistence),
            coordinator: coordinator
        )
    }

    static func makeCatchPokemonViewModel(
        persistence: PokemonPersistenceProtocol
    ) -> CatchPokemonViewModel {
        let repository = CatchPokemonRepository(persistence: persistence)
        let useCase = CatchPokemonUseCase(repository: repository)
        return CatchPokemonViewModel(useCase: useCase)
    }
}
