

import SwiftUI

struct CountryTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProDisplay-Regular", size: 12))
            .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15).opacity(0.6))
    }
}

struct CountryTextNilModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("SFProDisplay-Regular", size: 12))
            .foregroundColor(.clear)
    }
}

extension View {
    func countryStyle() -> some View {
        self.modifier(CountryTextModifier())
    }
    func countryNilStyle() -> some View {
        self.modifier(CountryTextNilModifier())
    }
}
