//
//  CatchPokemonView.swift
//  Pokedex
//
//  Created by Clara on 02/10/26.
//

import SwiftUI
import DesignSystem

public struct CatchPokemonView: View {
    let pokemon: Pokemon
    @StateObject var viewModel: CatchPokemonViewModel
    @State private var nickname = ""
    private let coordinator: PokedexCoordinator

    init(pokemon: Pokemon, viewModel: CatchPokemonViewModel, coordinator: PokedexCoordinator) {
        self.pokemon = pokemon
        _viewModel = StateObject(wrappedValue: viewModel)
        self.coordinator = coordinator
    }

    public var body: some View {
        VStack(spacing: 24) {
            if viewModel.hasAttemptedCatch {
                if viewModel.error != nil {
                    Text("Could not save Pokemon")
                } else if viewModel.didCatch {
                    caughtView
                } else {
                    failedView
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            guard !viewModel.hasAttemptedCatch else { return }
            viewModel.catchPokemon(pokemon, randomBool: Bool.random())
        }
    }

    @ViewBuilder
    public var caughtView: some View {
        VStack {
            Text("You caught a Pokemon!")
            CachedAsyncImage(
                urlString: pokemon.sprite,
                content: { $0.resizable().scaledToFit().frame(maxHeight: 280) },
                placeholder: { ProgressView() },
                error: { IconAssets.photo.resizable().frame(width: 250, height: 250) }
            )
            if viewModel.error != nil {
                Text("Could not save Pokemon. Please try again.")
            } else if !viewModel.isSaved {
                Text("Give your pokemon a nickname")
                TextField(pokemon.name, text: $nickname)
                    .textFieldStyle(.roundedBorder)
                Button("OK") {
                    viewModel.saveCaughtPokemon(pokemon, nickname: nickname)
                }
                .buttonStyle(ShadowPressedButtonStyle())
            }
        }
        .onChange(of: viewModel.isSaved) { _, isSaved in
            if isSaved {
                coordinator.pop()
            }
        }
        .padding(32)
    }

    @ViewBuilder
    public var failedView: some View {
        VStack {
            Text("Pokemon escaped!")
            Button("OK") {
                coordinator.pop()
            }
            .buttonStyle(ShadowPressedButtonStyle())
        }
        .padding(32)
    }
}
