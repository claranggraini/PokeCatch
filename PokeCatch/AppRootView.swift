//
//  ContentView.swift
//  PokeCatch
//
//  Created by Clara on 01/10/26.
//

import SwiftUI
import DesignSystem
import Navigation
import Networking
import Pokedex

public struct AppRootView: View {

    @ObservedObject var coordinator: AppCoordinator
    let networkClient: NetworkClientProtocol

    public init(coordinator: AppCoordinator, networkClient: NetworkClientProtocol) {
        self.coordinator = coordinator
        self.networkClient = networkClient
    }

    public var body: some View {
        TabView(selection: $coordinator.selectedTab) {

            PokedexNavigationView(
                path: $coordinator.pokedexPath,
                networkClient: networkClient
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

public struct MyPokemonNavigationView: View {

    @Binding var path: NavigationPath

    public init(path: Binding<NavigationPath>) {
        self._path = path
    }

    public var body: some View {
        NavigationStack(path: $path) {
            EmptyView()
        }
    }
}
