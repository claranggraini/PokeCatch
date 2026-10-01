import SwiftUI
import UIKit

public enum AppColors {
    public static let gray = Color("backgroundGray", bundle: .module)
    public static let subtitle = Color.secondary
    public static let white = Color.white

    /// Type color from the asset catalog, falling back to gray
    /// for unknown types (e.g. "stellar", "shadow").
    /// NOTE: `bundle: .module` is required — without it the lookup
    /// hits the main app bundle, where these assets don't exist.
    public static func getPokemonTypeColor(_ type: String) -> Color {
        if UIColor(named: type, in: .module, compatibleWith: nil) != nil {
            return Color(type, bundle: .module)
        }
        return .white
    }
}
