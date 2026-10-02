//
//  MyPokemonCoordinator.swift
//  MyPokemon
//
//  Created by Clara on 02/10/26.
//

import SwiftUI
import Combine

@MainActor
public final class MyPokemonCoordinator: ObservableObject {
    @Published public var path = NavigationPath()

    public init() {}

    public func push(_ route: MyPokemonRoute) {
        path.append(route)
    }

    public func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    public func popToRoot() {
        path = NavigationPath()
    }
}
