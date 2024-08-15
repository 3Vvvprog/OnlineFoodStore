

import SwiftUI

struct FavouriteSection: View {
    
    // MARK: - Properties
    
    private(set) var isFavorite: Bool
    private(set) var toggleFavoriteAction: () -> Void
    private let color = Color(.white).opacity(0.8)
    
    // MARK: - Body
    
    var body: some View {
        makeUI()
    }
    
    // MARK: - UI
    
    private func makeUI() -> some View {
        VStack {
            Button(action: {
                print("A picture with some kind of receipt was clicked")
            }, label: {
                Image("kakoiToCheck")
            })
            .padding(9)
            .buttonStyle(PlainButtonStyle())
            Button(action: {
                toggleFavoriteAction()
            }, label: {
                Image(isFavorite ? "heartFilled" : "heart")
            })
            .padding(.bottom, 10)
            .buttonStyle(PlainButtonStyle())
        }
        .background(color)
        .clipShape(.rect(topLeadingRadius: 0, bottomLeadingRadius: 16, bottomTrailingRadius: 0, topTrailingRadius: 0))
    }
    
}

// MARK: - Preview

#Preview {
    FavouriteSection(isFavorite: true, toggleFavoriteAction: {})
}
