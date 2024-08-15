

import SwiftUI

struct RatingAndDiscountRow: View {
    
    // MARK: - Properties
    
    private(set) var rating: Double
    private(set) var discount: Double?
    
    // MARK: - Body
    
    var body: some View {
        makeUI()
    }
    
    // MARK: - UI
    
    private func makeUI() -> some View {
        HStack(spacing: 4) {
            Image("starForReview")
                .padding(.vertical, 4)
            Text("\(rating, specifier: "%.1f")")
                .font(Font.custom("SFProDisplay-Regular", size: 12))
            Spacer()
            if let discountText = discount {
                Text("\(discountText, specifier: "%.0f")%")
                    .font(Font.custom("CeraRoundPro-Bold", size: 16))
                    .foregroundStyle(Color.discountRed)
            }
        }
        .padding(.horizontal, 6)
    }
    
}

// MARK: - Preview

#Preview {
    RatingAndDiscountRow(rating: 4.57, discount: 24.00)
}
