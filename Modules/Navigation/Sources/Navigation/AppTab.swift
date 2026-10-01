//
//  AppTab.swift
//  Navigation
//
//  Created by Clara on 01/10/26.
//

public enum AppTab: Hashable {
    case pokedex
    case myPokemon
    
    public var title: String {
        switch self {
        case .pokedex:
            "Pokedex"
        case .myPokemon:
            "My Pokemon"
        }
    }
}
