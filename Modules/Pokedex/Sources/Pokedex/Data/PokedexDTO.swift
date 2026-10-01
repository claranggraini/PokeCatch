//
//  PokedexDTO.swift
//  Pokedex
//
//  Created by Clara on 01/10/26.
//

import Foundation

struct SpeciesResponse: Decodable{
    let name: String?
    let url: URL?
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
    }
}

struct SpriteResponse: Decodable{
    let other: Other?
    
    enum CodingKeys: CodingKey {
        case other
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.other = try container.decodeIfPresent(Other.self, forKey: .other)
    }
}

struct Other: Decodable{
    let officialArtwork: OfficialArtworkResponse?
    enum CodingKeys: String, CodingKey{
        case officialArtwork = "official-artwork"
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.officialArtwork = try container.decodeIfPresent(OfficialArtworkResponse.self, forKey: .officialArtwork)
    }
    
}

struct OfficialArtworkResponse: Decodable{
    let frontDefault: URL?
    enum CodingKeys: String, CodingKey{
        case frontDefault = "front_default"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frontDefault = try container.decodeIfPresent(URL.self, forKey: .frontDefault)
    }
}

struct StatCategory: Decodable{
    let baseStat: Int?
    let stat: StatResponse?
    enum CodingKeys: String, CodingKey{
        case baseStat = "base_stat"
        case stat
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseStat = try container.decodeIfPresent(Int.self, forKey: .baseStat)
        self.stat = try container.decodeIfPresent(StatResponse.self, forKey: .stat)
    }
}

struct StatResponse: Decodable{
    let name: String?
    enum CodingKeys: CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}

struct TypeCategoryResponse: Decodable{
    let type: PokemonTypeResponse?
    
    enum CodingKeys: CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(PokemonTypeResponse.self, forKey: .type)
    }
}

struct PokemonTypeResponse: Decodable{
    let name: String?
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}

struct MoveCategoryResponse: Decodable{
    let move: MoveResponse?
    var versionDetails: [MoveVersionDetailResponse]?
    
    enum CodingKeys: String, CodingKey{
        case versionDetails = "version_group_details"
        case move
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.versionDetails = try container.decodeIfPresent([MoveVersionDetailResponse].self, forKey: .versionDetails)
        self.move = try container.decodeIfPresent(MoveResponse.self, forKey: .move)
    }
}

struct MoveResponse: Decodable{
    let name: String?
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}

struct MoveVersionDetailResponse: Decodable{
    let levelLearnedAt: Int?
    let moveLearnMethod: MoveLearnedMethodResponse?
    
    enum CodingKeys: String, CodingKey{
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.levelLearnedAt = try container.decodeIfPresent(Int.self, forKey: .levelLearnedAt)
        self.moveLearnMethod = try container.decodeIfPresent(MoveLearnedMethodResponse.self, forKey: .moveLearnMethod)
    }
}

struct MoveLearnedMethodResponse: Decodable{
    let name: String?
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}

struct PokemonResponse: Decodable{
    let id: Int?
    let name: String?
    let species: SpeciesResponse?
    let sprites: SpriteResponse?
    let stats: [StatCategory]?
    let moves: [MoveCategoryResponse]?
    let types: [TypeCategoryResponse]?
    let height: Int?
    let weight: Int?
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case species
        case sprites
        case stats
        case moves
        case types
        case height
        case weight
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.species = try container.decodeIfPresent(SpeciesResponse.self, forKey: .species)
        self.sprites = try container.decodeIfPresent(SpriteResponse.self, forKey: .sprites)
        self.stats = try container.decodeIfPresent([StatCategory].self, forKey: .stats)
        self.moves = try container.decodeIfPresent([MoveCategoryResponse].self, forKey: .moves)
        self.types = try container.decodeIfPresent([TypeCategoryResponse].self, forKey: .types)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
        self.weight = try container.decodeIfPresent(Int.self, forKey: .weight)
    }
}

struct PokemonListResponse: Decodable{
    let results: [PokemonListResult]
}

struct PokemonListResult: Decodable{
    let name: String?
    let url: URL?
}
