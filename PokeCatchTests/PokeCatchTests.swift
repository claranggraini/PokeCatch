//
//  PokeCatchTests.swift
//  PokeCatchTests
//
//  Created by Clara on 01/10/26.
//

import Testing
@testable import PokeCatch

struct PokeCatchTests {

    @MainActor
    @Test func repeatedCatchesCreateSeparateRecords() throws {
        let controller = PersistenceController(inMemory: true)
        let persistence = CoreDataPokemonPersistence(controller: controller)

        try persistence.saveCaughtPokemon(
            pokedexID: 25, nickname: "Sparky", sprite: "sprite", height: 4, weight: 60, types: []
        )
        try persistence.saveCaughtPokemon(
            pokedexID: 25, nickname: "Pikachu", sprite: "sprite", height: 4, weight: 60, types: []
        )

        let caught = try controller.fetchPokemonEntities()
        #expect(caught.count == 2)
        #expect(Set(caught.map(\.id)) == Set([Int32(25), Int32(26)]))
        #expect(caught.allSatisfy { $0.pokedexID == 25 })
        #expect(Set(caught.compactMap(\.name)) == Set(["Sparky", "Pikachu"]))
    }

}
