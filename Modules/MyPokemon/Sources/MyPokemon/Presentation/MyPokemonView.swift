//
//  MyPokemonView.swift
//  MyPokemon
//
//  Created by Clara on 02/10/26.
//

import SwiftUI
import DesignSystem

public struct MyPokemonView: View {
    @StateObject var viewModel: MyPokemonViewModel
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    init(viewModel: MyPokemonViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(viewModel.myPokemonList, id: \.id) { pokemon in
                    pokemonCard(pokemon)
                }
            }
            .padding()
        }
        .navigationTitle("My Pokemon")
        .overlay {
            if viewModel.myPokemonList.isEmpty && viewModel.error == nil {
                ContentUnavailableView("No caught Pokemon", systemImage: "tray")
            }
        }
        .overlay(alignment: .bottom) {
            if let name = viewModel.releasedPokemonName {
                Text("\(name) was successfully released")
                    .font(.callout.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(.black.opacity(0.85), in: Capsule())
                    .padding(.bottom, 20)
            }
        }
        .alert("Unable to load or release Pokemon", isPresented: Binding(
            get: { viewModel.error != nil },
            set: { if !$0 { viewModel.clearError() } }
        )) {
            Button("OK", role: .cancel) { viewModel.clearError() }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "Please try again.")
        }
        .onAppear { viewModel.load() }
        .task(id: viewModel.releasedPokemonName) {
            guard viewModel.releasedPokemonName != nil else { return }
            try? await Task.sleep(for: .seconds(3))
            if !Task.isCancelled { viewModel.clearToast() }
        }
    }

    @ViewBuilder
    public func pokemonCard(_ pokemon: MyPokemon) -> some View {
        VStack(spacing: 8) {
            CachedAsyncImage(
                urlString: pokemon.sprite,
                content: { $0.resizable().scaledToFit().frame(height: 80) },
                placeholder: { ProgressView().frame(height: 80) },
                error: { IconAssets.photo.resizable().scaledToFit().frame(height: 80) }
            )
            VStack(spacing: 8) {
                Text(pokemon.name)
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)

                chipsView(pokemon.types)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .overlay(alignment: .topTrailing) {
            Button {
                viewModel.release(pokemon)
            } label: {
                IconAssets.delete
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(10)
            }
            .accessibilityLabel("Release \(pokemon.name)")
        }
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(AppColors.gray, lineWidth: 1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    @ViewBuilder
    public func chipsView(_ types: [MyPokemonType]) -> some View {
        HStack(spacing: 4) {
            ForEach(types, id: \.self) { type in
                Text(type.name.capitalized)
                    .font(.caption2.weight(.semibold))
                    .foregroundColor(AppColors.white)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 6)
                    .background(type.color ?? .white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .lineLimit(1)
    }
}
