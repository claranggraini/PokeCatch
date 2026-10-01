//
//  ContentView.swift
//  PokeCatch
//
//  Created by Clara on 01/10/26.
//

import SwiftUI
import DesignSystem
import Navigation

public struct AppRootView: View {

    @StateObject private var coordinator: AppCoordinator

    public init(coordinator: AppCoordinator) {
        _coordinator = StateObject(wrappedValue: coordinator)
    }

    public var body: some View {
        TabView(selection: $coordinator.selectedTab) {

            PokedexNavigationView(
                path: $coordinator.pokedexPath
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

public struct PokedexNavigationView: View {

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
