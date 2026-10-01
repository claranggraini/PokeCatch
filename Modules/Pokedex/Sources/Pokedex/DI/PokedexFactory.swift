import Networking

@MainActor
enum PokedexFactory {
    static func makeViewModel(networkClient: NetworkClientProtocol) -> PokedexViewModel {
        let repository = PokedexRepository(networkClient: networkClient)
        let useCase = PokedexUseCase(repository: repository)
        return PokedexViewModel(useCase: useCase)
    }

    static func makePokedexView(networkClient: NetworkClientProtocol) -> PokedexView {
        PokedexView(viewModel: makeViewModel(networkClient: networkClient))
    }
}
