import MyPokemon

@MainActor
struct CoreDataMyPokemonPersistence: MyPokemonPersistenceProtocol {
    let controller: PersistenceController

    func fetchCaughtPokemon() throws -> [MyPokemon] {
        try controller.fetchPokemonEntities().map { entity in
            MyPokemon(
                id: Int(entity.id),
                name: entity.name ?? "Pokemon",
                sprite: entity.sprite ?? "",
                types: (entity.pokemonType as? [String] ?? []).map { MyPokemonType(name: $0) }
            )
        }
    }

    func deleteCaughtPokemon(id: Int) throws {
        try controller.deletePokemonEntity(id: Int32(id))
    }
}
