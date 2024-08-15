

import SwiftUI

struct ReviewAndRatingRow: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ProductListViewModel
    private(set) var rating: Double
    private(set) var reviewCount: Int
    
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
            Rectangle()
                .foregroundStyle(Color.customGray)
                .frame(width: 16, height: 1)
                .rotationEffect(Angle(degrees: 90))
                .padding(.horizontal, -4)
            Text(viewModel.reviewCountText(for: reviewCount))
                .font(Font.custom("SFProDisplay-Regular", size: 12))
                .foregroundStyle(Color.customGray)
        }
        .padding(.leading, 6)
    }
    
}

// MARK: - Preview

#Preview {
    ReviewAndRatingRow(viewModel: .mock, rating: 4.57, reviewCount: 24)
}

extension ProductListViewModel {
    static var mock: ProductListViewModel {
        let cartManager = CartManager()
        let viewModel = ProductListViewModel(cartManager: cartManager)
        return viewModel
    }
}
