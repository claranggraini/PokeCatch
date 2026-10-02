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

struct AppRootView: View {

    @ObservedObject var coordinator: AppCoordinator
    let networkClient: NetworkClientProtocol
    let persistence: PokemonPersistenceProtocol

    init(
        coordinator: AppCoordinator,
        networkClient: NetworkClientProtocol,
        persistence: PokemonPersistenceProtocol
    ) {
        self.coordinator = coordinator
        self.networkClient = networkClient
        self.persistence = persistence
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
                path: $coordinator.myPokemonPath
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

struct MyPokemonNavigationView: View {

    @Binding var path: NavigationPath

    init(path: Binding<NavigationPath>) {
        self._path = path
    }

    var body: some View {
        NavigationStack(path: $path) {
            EmptyView()
        }
    }
}
