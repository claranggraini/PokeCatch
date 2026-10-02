//
//  Persistence.swift
//  PokeCatch
//
//  Created by Clara on 01/10/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        PersistenceController(inMemory: true)
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PokeCatch")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    @MainActor
    func fetchPokemonEntities() throws -> [PokemonEntity] {
        let request = PokemonEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \PokemonEntity.id, ascending: true)]
        return try container.viewContext.fetch(request)
    }

    @MainActor
    func fetchPokemonEntity(id: Int32) throws -> PokemonEntity? {
        let request = PokemonEntity.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id == %d", id)
        return try container.viewContext.fetch(request).first
    }

    @MainActor
    @discardableResult
    func insertCaughtPokemon(
        pokedexID: Int32,
        nickname: String,
        sprite: String,
        height: Int32,
        weight: Int32,
        color: String?,
        pokemonType: [String]?
    ) throws -> PokemonEntity {
        let request = PokemonEntity.fetchRequest()
        let usedIDs = Set(try container.viewContext.fetch(request).map(\.id))
        var recordID = pokedexID
        while usedIDs.contains(recordID) {
            guard recordID < Int32.max else {
                throw CocoaError(.validationNumberTooLarge)
            }
            recordID += 1
        }

        let entity = PokemonEntity(context: container.viewContext)
        entity.id = recordID
        entity.pokedexID = pokedexID
        entity.name = nickname
        entity.sprite = sprite
        entity.height = height
        entity.weight = weight
        entity.color = color
        entity.pokemonType = pokemonType as NSArray?
        try save()
        return entity
    }

    @MainActor
    @discardableResult
    func upsertPokemon(
        pokedexID: Int32,
        id: Int32,
        name: String?,
        sprite: String?,
        height: Int32,
        weight: Int32,
        color: String?,
        pokemonType: [String]?
    ) throws -> PokemonEntity {
        let entity = try fetchPokemonEntity(id: id) ?? PokemonEntity(context: container.viewContext)
        entity.pokedexID = pokedexID
        entity.id = id
        entity.name = name
        entity.sprite = sprite
        entity.height = height
        entity.weight = weight
        entity.color = color
        entity.pokemonType = pokemonType as NSArray?
        try save()
        return entity
    }

    @MainActor
    func deletePokemonEntity(id: Int32) throws {
        guard let entity = try fetchPokemonEntity(id: id) else { return }
        container.viewContext.delete(entity)
        try save()
    }

    @MainActor
    private func save() throws {
        guard container.viewContext.hasChanges else { return }
        try container.viewContext.save()
    }
}
