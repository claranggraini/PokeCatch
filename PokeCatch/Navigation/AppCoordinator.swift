import SwiftUI
import Combine
import Pokedex

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var selectedTab: AppTab = .pokedex
    @Published var myPokemonPath = NavigationPath()
    let pokedexCoordinator: PokedexCoordinator

    init() {
        self.pokedexCoordinator = PokedexCoordinator()
    }

    init(pokedexCoordinator: PokedexCoordinator) {
        self.pokedexCoordinator = pokedexCoordinator
    }

    func selectTab(_ tab: AppTab) {
        selectedTab = tab
    }

    func openPokedex() {
        selectedTab = .pokedex
    }

    func openMyPokemon() {
        selectedTab = .myPokemon
    }

    func handle(_ route: AppRoute) {
        selectedTab = route.targetTab

        switch route {
        case .pokedex:
            pokedexCoordinator.popToRoot()
        case .myPokemon:
            myPokemonPath = NavigationPath()
        case .pokemonDetail(let id):
            pokedexCoordinator.showPokemonDetail(pokemon: nil, id: id)
        }
    }
}
