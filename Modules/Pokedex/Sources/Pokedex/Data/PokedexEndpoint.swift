//
//  PokedexEndpoint.swift
//  Pokedex
//
//  Created by Clara on 01/10/26.
//
import Foundation
import Networking

enum PokedexEndpoint {
    case getPokemons
    case getPokemonDetail(name: String)
}

extension PokedexEndpoint: Endpoint {
    var host: String {
        "pokeapi.co"
    }

    var path: String {
        switch self {
        case .getPokemons:
            return "/api/v2/pokemon"
        case .getPokemonDetail(let name):
            return "/api/v2/pokemon/\(name)"
        }
    }
    
    var header: [String : String]? {
        switch self{
        default:
            return nil
        }
        
    }

    var method: HTTPMethod {
        switch self {
        case .getPokemons:
            return .get
        case .getPokemonDetail:
            return .get
        }
    }

    var body: [String : Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var query: [URLQueryItem]? {
        switch self{
        case .getPokemons:
            return [URLQueryItem(name: "limit", value: String(20))]
        default:
            return nil
        }
    }
}
