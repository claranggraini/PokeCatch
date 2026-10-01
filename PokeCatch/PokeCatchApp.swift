//
//  PokeCatchApp.swift
//  PokeCatch
//
//  Created by Clara on 01/10/26.
//

import SwiftUI
import CoreData
import Navigation

@main
struct PokeCatchApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var coordinator: AppCoordinator

        init() {
            let coordinator = AppCoordinator()

            _coordinator = StateObject(
                wrappedValue: coordinator
            )
        }
    var body: some Scene {
        WindowGroup {
            AppRootView(coordinator: coordinator)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
