//
//  Pokemon.swift
//  Pokedex
//
//  Created by Clara on 01/10/26.
//

import Foundation
import DesignSystem
import SwiftUI

struct PokemonList {
    let name: String
}

struct Pokemon {
    let id: Int
    let name: String
    let sprite: String
    let stats: [Stat]
    let moves: [Move]
    let types: [PokemonType]
    let height: Int
    let weight: Int
    var wasCaught: Bool
    
    init(id: Int?, name: String?, sprite: String?, stats: [Stat]?, moves: [Move]?, types: [PokemonType]?, height: Int?, weight: Int?, wasCaught: Bool) {
        
        self.id = id ?? 0
        self.name = name ?? "Pokemon Name"
        self.sprite = sprite ?? ""
        self.stats = stats ?? []
        self.moves = moves?.sorted(by: {$0.levelLearnedAt ?? 0 < $1.levelLearnedAt ?? 0}) ?? []
        self.types = types ?? []
        self.height = height ?? 0
        self.weight = weight ?? 0
        self.wasCaught = wasCaught
    }
    
    init(){
        self.id = 0
        self.name = "Pokemon Name"
        self.sprite = ""
        self.stats = []
        self.moves = []
        self.types = []
        self.height = 0
        self.weight = 0
        self.wasCaught = false
    }
}

struct Stat {
    let baseStat: Int?
    let name: String?
    
    init(baseStat: Int?, name: String?) {
        self.baseStat = baseStat ?? 0
        self.name = name ?? "Stat Name"
    }
}

struct Move {
    let name: String?
    let levelLearnedAt: Int?
    
    init(name: String?, levelLearnedAt: Int?) {
        self.name = name ?? "Move Name"
        self.levelLearnedAt = levelLearnedAt ?? 0
    }
}

struct PokemonType {
    let name: String?
    let color: Color?
    
    init(name: String?) {
        self.name = name ?? "Pokemon Type"
        self.color = AppColors.getPokemonTypeColor(name ?? "")
    }
}
