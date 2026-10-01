//
//  PokeCatchApp.swift
//  PokeCatch
//
//  Created by Clara on 01/10/26.
//

import SwiftUI
import CoreData
import Networking
import Navigation

@main
struct PokeCatchApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var coordinator = AppCoordinator()
    private let networkClient: NetworkClientProtocol = NetworkService()

    var body: some Scene {
        WindowGroup {
            AppRootView(coordinator: coordinator, networkClient: networkClient)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
