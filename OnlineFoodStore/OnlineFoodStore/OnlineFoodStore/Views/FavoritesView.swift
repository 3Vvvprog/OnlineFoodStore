
import SwiftUI

struct FavoritesView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: FavoritesViewModel
    
    // MARK: - Body
    
    var body: some View {
        makeUI()
    }
    
    // MARK: - UI
    
    private func makeUI() -> some View {
        NavigationView {
            Group {
                if !viewModel.favoriteProducts.isEmpty {
                    List {
                        ForEach(viewModel.favoriteProducts, id: \.id) { product in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(product.basicInfo.name)
                                        .font(.headline)
                                    Text("\(product.finalPrice, specifier: "%.2f") ₽")
                                        .font(.body)
                                }
                                Spacer()
                                Button(action: {
                                    viewModel.toggleFavorite(product: product)
                                }) {
                                    Image(systemName: product.additionalInfo.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(product.additionalInfo.isFavorite ? .red : .gray)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .contentShape(Rectangle())
                        }
                        .onDelete(perform: viewModel.deleteFavorites)
                    }
                } else {
                    Text("Теперь тут пусто 🥲")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                }
            }
            .navigationTitle("Избранные товары")
        }
    }
    
}

// MARK: - Preview

#Preview {
    let cartManager = CartManager()
    let productListViewModel = ProductListViewModel(cartManager: cartManager)
    return FavoritesView(viewModel: FavoritesViewModel(productListViewModel: productListViewModel))
}
