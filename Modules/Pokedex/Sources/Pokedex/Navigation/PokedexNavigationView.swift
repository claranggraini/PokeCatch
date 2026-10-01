import SwiftUI
import Networking

public struct PokedexNavigationView: View {

    @Binding var path: NavigationPath
    let networkClient: NetworkClientProtocol

    public init(path: Binding<NavigationPath>, networkClient: NetworkClientProtocol) {
        self._path = path
        self.networkClient = networkClient
    }

    public var body: some View {
        NavigationStack(path: $path) {
            PokedexFactory.makePokedexView(networkClient: networkClient)
                .navigationDestination(for: PokedexRoute.self) { route in
                    switch route {
                    case .detail(let pokemon):
                        PokedexFactory.makePokemonDetailView(pokemon: pokemon)
                    }
                }
        }
    }
}
