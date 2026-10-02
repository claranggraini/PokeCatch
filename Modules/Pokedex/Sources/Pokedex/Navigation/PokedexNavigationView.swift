import SwiftUI
import Networking

public struct PokedexNavigationView: View {

    @ObservedObject private var coordinator: PokedexCoordinator
    let networkClient: NetworkClientProtocol

    public init(coordinator: PokedexCoordinator, networkClient: NetworkClientProtocol) {
        self.coordinator = coordinator
        self.networkClient = networkClient
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            PokedexFactory.makePokedexView(networkClient: networkClient)
                .navigationDestination(for: PokedexRoute.self) { route in
                    switch route {
                    case .detail(let pokemon, let id):
                        PokedexFactory.makePokemonDetailView(pokemon: pokemon, id: id, networkClient: networkClient)
                    }
                }
        }
    }
}
