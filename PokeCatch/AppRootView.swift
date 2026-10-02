//
//  ContentView.swift
//  PokeCatch
//
//  Created by Clara on 01/10/26.
//

import SwiftUI
import DesignSystem
import Networking
import Pokedex
import MyPokemon

struct AppRootView: View {

    @ObservedObject var coordinator: AppCoordinator
    let networkClient: NetworkClientProtocol
    let persistence: PokemonPersistenceProtocol
    let myPokemonPersistence: MyPokemonPersistenceProtocol

    init(
        coordinator: AppCoordinator,
        networkClient: NetworkClientProtocol,
        persistence: PokemonPersistenceProtocol,
        myPokemonPersistence: MyPokemonPersistenceProtocol
    ) {
        self.coordinator = coordinator
        self.networkClient = networkClient
        self.persistence = persistence
        self.myPokemonPersistence = myPokemonPersistence
    }

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {

            PokedexNavigationView(
                coordinator: coordinator.pokedexCoordinator,
                networkClient: networkClient,
                persistence: persistence
            )
            .tabItem {
                IconAssets.pokedex
                Text(AppTab.pokedex.title)
            }
            .tag(AppTab.pokedex)

            MyPokemonNavigationView(
                coordinator: coordinator.myPokemonCoordinator,
                persistence: myPokemonPersistence
            )
            .tabItem {
                IconAssets.inventory
                Text(AppTab.myPokemon.title)
            }
            .tag(AppTab.myPokemon)
        }
        .environmentObject(coordinator)
    }
}
