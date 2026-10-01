//
//  PokeCatchApp.swift
//  PokeCatch
//
//  Created by Clara on 01/10/26.
//

import SwiftUI
import CoreData

@main
struct PokeCatchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
