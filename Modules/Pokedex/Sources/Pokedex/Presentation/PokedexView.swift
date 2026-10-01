//
//  PokedexView.swift
//  Pokedex
//
//  Created by Clara on 01/10/26.
//

import SwiftUI

public struct PokedexView: View {
    @StateObject var viewModel: PokedexViewModel

    init(viewModel: PokedexViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            
        }
        .task {
            await viewModel.loadPokemonList()
        }
    }
}
