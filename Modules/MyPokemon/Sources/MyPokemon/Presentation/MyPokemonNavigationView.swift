//
//  MyPokemonNavigationView.swift
//  MyPokemon
//
//  Created by Clara on 02/10/26.
//

import SwiftUI

public struct MyPokemonNavigationView: View {
    @ObservedObject private var coordinator: MyPokemonCoordinator
    private let persistence: MyPokemonPersistenceProtocol

    public init(coordinator: MyPokemonCoordinator, persistence: MyPokemonPersistenceProtocol) {
        self.coordinator = coordinator
        self.persistence = persistence
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            MyPokemonFactory.makeMyPokemonView(persistence: persistence)
        }
    }
}
