import SwiftUI
import Combine
import Pokedex
import MyPokemon

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var selectedTab: AppTab = .pokedex
    let myPokemonCoordinator: MyPokemonCoordinator
    let pokedexCoordinator: PokedexCoordinator

    init() {
        self.pokedexCoordinator = PokedexCoordinator()
        self.myPokemonCoordinator = MyPokemonCoordinator()
    }

    init(pokedexCoordinator: PokedexCoordinator) {
        self.pokedexCoordinator = pokedexCoordinator
        self.myPokemonCoordinator = MyPokemonCoordinator()
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
            myPokemonCoordinator.popToRoot()
        case .pokemonDetail(let id):
            pokedexCoordinator.showPokemonDetail(pokemon: nil, id: id)
        }
    }
}
