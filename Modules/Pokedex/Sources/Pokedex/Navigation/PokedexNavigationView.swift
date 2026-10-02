import SwiftUI
import Networking

public struct PokedexNavigationView: View {

    @ObservedObject private var coordinator: PokedexCoordinator
    let networkClient: NetworkClientProtocol
    let persistence: PokemonPersistenceProtocol

    public init(
        coordinator: PokedexCoordinator,
        networkClient: NetworkClientProtocol,
        persistence: PokemonPersistenceProtocol
    ) {
        self.coordinator = coordinator
        self.networkClient = networkClient
        self.persistence = persistence
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            PokedexFactory.makePokedexView(networkClient: networkClient)
                .navigationDestination(for: PokedexRoute.self) { route in
                    switch route {
                    case .detail(let pokemon, let id):
                        PokedexFactory.makePokemonDetailView(
                            pokemon: pokemon,
                            id: id,
                            networkClient: networkClient,
                            coordinator: coordinator
                        )
                    case .catchPokemon(let pokemon):
                        PokedexFactory.makeCatchPokemonView(
                            pokemon: pokemon,
                            persistence: persistence,
                            coordinator: coordinator
                        )
                    }
                }
        }
    }
}
