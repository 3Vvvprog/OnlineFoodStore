

import SwiftUI

struct ProductBadge: View {
    
    // MARK: - Properties
    
    private(set) var type: String
    
    var color: Color {
        return ProductBadgeType(rawValue: type)?.color ?? .clear
    }
    
    // MARK: - Body
    
    var body: some View {
        makeUI()
    }
    
    // MARK: - UI
    
    private func makeUI() -> some View {
        if !type.isEmpty {
            return AnyView(
                Text(type)
                    .font(Font.custom("SFProDisplay-Regular", size: 10))
                    .foregroundStyle(Color.white)
                    .padding(EdgeInsets(top: 2, leading: 12, bottom: 4, trailing: 6))
                    .background(color)
                    .clipShape(.rect(topLeadingRadius: 6, bottomLeadingRadius: 0, bottomTrailingRadius: 6, topTrailingRadius: 6))
            )
        } else {
            return AnyView(EmptyView())
        }
    }
    
}

// MARK: - Preview

#Preview {
    ProductBadge(type: "Удар по ценам")
}
