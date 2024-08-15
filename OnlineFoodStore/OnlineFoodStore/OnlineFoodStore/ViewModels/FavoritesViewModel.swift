

import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var favoriteProducts: [Product] = []
    var productListViewModel: ProductListViewModel
    
    // MARK: - init
    
    init(productListViewModel: ProductListViewModel) {
        self.productListViewModel = productListViewModel
        setupSubscriptions()
    }
    
    // MARK: - Sub
    
    private func setupSubscriptions() {
        productListViewModel.$products
            .map { products in
                products.filter { $0.additionalInfo.isFavorite }
            }
            .assign(to: &$favoriteProducts)
    }
    
    // MARK: - Favourite
    
    func toggleFavorite(product: Product) {
        if let index = productListViewModel.products.firstIndex(where: { $0.id == product.id }) {
            productListViewModel.products[index].additionalInfo.isFavorite.toggle()
        }
    }
    
    func deleteFavorites(at offsets: IndexSet) {
        for index in offsets {
            let product = favoriteProducts[index]
            setFavoriteStatus(for: product, isFavorite: false)
        }
    }
    
    private func setFavoriteStatus(for product: Product, isFavorite: Bool) {
        if let index = productListViewModel.products.firstIndex(where: { $0.id == product.id }) {
            productListViewModel.products[index].additionalInfo.isFavorite = isFavorite
        }
    }
    
}
