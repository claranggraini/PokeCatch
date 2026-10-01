//
//  PokedexMapper.swift
//  Pokedex
//
//  Created by Clara on 01/10/26.
//

import Foundation
import UIKit

final class PokedexMapper {
   
    static func mapPokemonListResponsesToModel(input pokemonListResponse: PokemonListResponse) -> [PokemonList] {
     
        return pokemonListResponse.results.map { result in
           
            return PokemonList(name: result.name ?? "")
        }
    }
    
    static func mapPokemonResponsesToModel(input pokemonResponse: PokemonResponse, caughtPokemonsId: [Int]) -> Pokemon {
        var pokemonStat = Array<Stat>()
        var pokemonMoves = Array<Move>()
        var pokemonTypes = Array<PokemonType>()
        
        guard let pokemonResponseStats = pokemonResponse.stats else { return Pokemon()}
        
        guard let pokemonResponseMoves = pokemonResponse.moves else { return Pokemon() }
        
        guard let pokemonResponseTypes = pokemonResponse.types else {return Pokemon()}
        
        for pokeStat in pokemonResponseStats {
            pokemonStat.append(Stat(baseStat: pokeStat.baseStat, name: pokeStat.stat?.name))
        }
        
        for pokeType in pokemonResponseTypes {
            pokemonTypes.append(PokemonType(name: pokeType.type?.name))
        }
        
        let filteredPokemonMove = pokemonResponseMoves.filter({
            guard let versionDetail = $0.versionDetails else {return true}
            return versionDetail.contains(where: {
                $0.moveLearnMethod?.name == "level-up"
            })
        })
        
        for pokemonMove in filteredPokemonMove {
            
            pokemonMoves.append(Move(name: pokemonMove.move?.name, levelLearnedAt: pokemonMove.versionDetails?.first?.levelLearnedAt))
        }
        
        let caught = checkIfPokemonWasCaught(caughtPokemonsId: caughtPokemonsId, id: pokemonResponse.id ?? 0)
        
        return Pokemon(
            id: pokemonResponse.id,
            name: pokemonResponse.name,
            sprite: pokemonResponse.sprites?.other?.officialArtwork?.frontDefault?.absoluteString ?? "",
            stats: pokemonStat,
            moves: pokemonMoves,
            types: pokemonTypes,
            height: pokemonResponse.height,
            weight: pokemonResponse.weight,
            wasCaught: caught
        )
    }
    
    static func checkIfPokemonWasCaught(caughtPokemonsId: [Int], id: Int) -> Bool{
        if caughtPokemonsId.first(where: {
            $0 == id
        }) != nil{
            return true
        }
        
        return false
    }
}
