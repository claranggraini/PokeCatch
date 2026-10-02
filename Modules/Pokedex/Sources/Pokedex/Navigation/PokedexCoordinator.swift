import SwiftUI
import Combine

@MainActor
public final class PokedexCoordinator: ObservableObject {
    @Published public var path = NavigationPath()

    public init() {}

    public func push(_ route: PokedexRoute) {
        path.append(route)
    }

    public func showPokemonDetail(pokemon: Pokemon?, id: Int?) {
        push(.detail(pokemon, id))
    }

    public func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    public func popToRoot() {
        path = NavigationPath()
    }
}
