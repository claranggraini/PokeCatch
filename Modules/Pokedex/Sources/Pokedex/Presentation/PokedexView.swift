//
//  PokedexView.swift
//  Pokedex
//
//  Created by Clara on 01/10/26.
//

import SwiftUI
import DesignSystem

public struct PokedexView: View {
    @StateObject var viewModel: PokedexViewModel

    init(viewModel: PokedexViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        List(viewModel.pokemonList, id: \.id) { pokemon in
            NavigationLink(
                value:                 PokedexRoute.detail(pokemon: pokemon)
            ) {
                rowView(pokemon: pokemon)
            }
            .navigationLinkIndicatorVisibility(.hidden)
        }
        .navigationTitle("Pokedex")
        .task {
            await viewModel.loadPokemonList()
        }
    }
    
    @ViewBuilder
    func rowView(pokemon: Pokemon) -> some View {
        HStack(spacing: 16) {
            CachedAsyncImage(
                urlString: pokemon.sprite,
                content: { $0.resizable().scaledToFit().frame(width: 95, height: 95) },
                placeholder: { ProgressView() },
                error: { IconAssets.photo.resizable().scaledToFit().frame(width: 95, height: 95) }
            )
            
            Text("#\(pokemon.id) \(pokemon.name)")
                .font(.title2)
            
            Spacer()
            
            if pokemon.wasCaught {
                Image("ic_pokeball", bundle: .module)
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
}
