//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Clara on 01/10/26.
//

import SwiftUI
import DesignSystem

public struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel

    init(viewModel: PokemonDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(spacing: 24) {
            Text(viewModel.pokemon?.name.capitalized ?? "")
                .font(.title.bold())
            
            CachedAsyncImage(
                urlString: viewModel.pokemon?.sprite ?? "",
                content: { $0.resizable().scaledToFit().frame(maxHeight: 280) },
                placeholder: { ProgressView() },
                error: { IconAssets.photo.resizable().frame(width: 250, height: 250) }
            )
            
            VStack(alignment: .center, spacing: 24) {
                Text("#\(viewModel.pokemon?.id ?? 0)")
                    .font(.title2.bold())
                heightAndWeightView
                chipsView
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 36)
            .background(
                AppColors.gray
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            moveList
        }
        .padding(.horizontal, 24)
        .toolbar(.hidden, for: .tabBar)
        .task {
            await viewModel.load()
        }
    }
    
    @ViewBuilder
    var heightAndWeightView: some View {
        HStack {
            VStack {
                Text(viewModel.pokemon?.heightDisplay ?? "")
                Text("Height")
            }
            .font(.title2.bold())
            
            Spacer()
            
            VStack {
                Text(viewModel.pokemon?.weightDisplay ?? "")
                Text("Weight")
            }
            .font(.title2.bold())
        }
    }
    
    @ViewBuilder
    var chipsView: some View {
        HStack {
            ForEach(viewModel.pokemon?.types ?? [], id: \.self) { type in
                Text(type.name.capitalized)
                    .font(.body.weight(.semibold))
                    .foregroundColor(AppColors.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(type.color ?? .white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
    
    @ViewBuilder
    var moveList: some View {
        Text("Moves")
            .font(.title.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
        
        ScrollView {
            LazyVStack {
                ForEach(viewModel.pokemon?.moves ?? [], id: \.self) { move in
                    HStack {
                        Text(move.name ?? "")
                        Spacer()
                        Text(move.learnedAtDisplay)
                            .foregroundColor(AppColors.subtitle)
                    }
                    .padding()
                }
            }
        }
        .scrollBounceBehavior(.automatic)
        .frame(maxHeight: 160)
    }
}
