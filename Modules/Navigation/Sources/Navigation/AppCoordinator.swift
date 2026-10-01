import SwiftUI

@MainActor
public final class AppCoordinator: ObservableObject {

    @Published public var selectedTab: AppTab = .pokedex

    @Published public var pokedexPath = NavigationPath()
    @Published public var myPokemonPath = NavigationPath()

    public init() {}

    public func selectTab(_ tab: AppTab) {
        selectedTab = tab
    }

    public func popToRoot(_ tab: AppTab) {
        switch tab {
        case .pokedex:
            pokedexPath = NavigationPath()

        case .myPokemon:
            myPokemonPath = NavigationPath()
        }
    }
}
