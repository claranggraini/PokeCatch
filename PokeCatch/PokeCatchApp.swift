//
//  PokeCatchApp.swift
//  PokeCatch
//
//  Created by Clara on 01/10/26.
//

import SwiftUI
import CoreData
import Networking

@main
struct PokeCatchApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var coordinator = AppCoordinator()
    private let networkClient: NetworkClientProtocol = NetworkService()
    private let pokemonPersistence = CoreDataPokemonPersistence(
        controller: PersistenceController.shared
    )
    private let myPokemonPersistence = CoreDataMyPokemonPersistence(
        controller: PersistenceController.shared
    )

    var body: some Scene {
        WindowGroup {
            AppRootView(
                coordinator: coordinator,
                networkClient: networkClient,
                persistence: pokemonPersistence,
                myPokemonPersistence: myPokemonPersistence
            )
        }
    }
}
