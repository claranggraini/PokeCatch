enum AppRoute: Codable, Equatable, Hashable, Sendable {
    case pokedex
    case myPokemon
    case pokemonDetail(id: Int)

    var targetTab: AppTab {
        switch self {
        case .pokedex:
            .pokedex
        case .myPokemon:
            .myPokemon
        case .pokemonDetail:
            .pokedex
        }
    }
}
