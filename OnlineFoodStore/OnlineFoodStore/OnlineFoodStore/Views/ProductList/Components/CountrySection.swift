

import SwiftUI

struct CountrySection: View {
    
    // MARK: - Properties
    
    private(set) var productCountry: String?
    
    // MARK: - Body
    
    var body: some View {
        makeUI()
    }
    
    // MARK: - UI
    
    private func makeUI() -> some View {
        HStack(spacing: 4) {
            if let countryName = productCountry, let country = Country(rawValue: countryName) {
                Text("\(countryName)")
                    .countryStyle()
                Text(country.flagImageName)
                    .countryStyle()
            } else {
                Text("")
                    .countryNilStyle()
                Text("")
                    .countryNilStyle()
            }
        }
        .padding(.top, 4)
        .padding([.leading], 8)
    }
    
}

// MARK: - Preview

#Preview {
    CountrySection(productCountry: "Франция")
}
