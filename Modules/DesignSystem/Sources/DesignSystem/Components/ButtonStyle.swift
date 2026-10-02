//
//  ButtonStyle.swift
//  DesignSystem
//
//  Created by Clara on 02/10/26.
//
import SwiftUI

public struct ShadowPressedButtonStyle: ButtonStyle {
    public var backgroundColor: Color = .blue
    public init(backgroundColor: Color = .blue) {
        self.backgroundColor = backgroundColor
    }
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
