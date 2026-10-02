//
//  MyPokemon.swift
//  MyPokemon
//
//  Created by Clara on 02/10/26.
//
import DesignSystem
import SwiftUI

public struct MyPokemon: Hashable {
    public let id: Int
    public let name: String
    public let sprite: String
    public let types: [MyPokemonType]

    public init(id: Int, name: String, sprite: String, types: [MyPokemonType]) {
        self.id = id
        self.name = name
        self.sprite = sprite
        self.types = types
    }
}

public struct MyPokemonType: Hashable {
    public let name: String

    var color: Color? {
        AppColors.getPokemonTypeColor(name)
    }

    public init(name: String?) {
        self.name = name ?? "Pokemon Type"
    }
}
