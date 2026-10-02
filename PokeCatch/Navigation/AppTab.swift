enum AppTab: Hashable {
    case pokedex
    case myPokemon

    var title: String {
        switch self {
        case .pokedex:
            "Pokedex"
        case .myPokemon:
            "My Pokemon"
        }
    }
}
