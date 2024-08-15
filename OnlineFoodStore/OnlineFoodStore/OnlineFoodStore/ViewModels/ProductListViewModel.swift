
import Foundation
import Combine
import SwiftUI

class ProductListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var products: [Product] = []
    private var cartManager: CartManaging
    private var cancellables = Set<AnyCancellable>()
    private var getUrl = "https://run.mocky.io/v3/9d1ffc48-4e11-4f74-9672-4560962648c9"
    
    // MARK: - init
    
    init(cartManager: CartManaging) {
        self.cartManager = cartManager
        fetchProducts()
    }
    
    // MARK: - Fetch Products
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Failed to fetch products:", error.localizedDescription)
        }
    }
    
    private func handleProducts(_ response: ProductResponse) {
        products = response.products
    }
    
    func fetchProducts() {
        guard let url = URL(string: getUrl) else { return }
        
        NetworkManager.shared.fetchProducts(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: handleProducts)
            .store(in: &cancellables)
    }
    
    // MARK: - Favorites
    
    func toggleFavorite(product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].additionalInfo.isFavorite.toggle()
            objectWillChange.send()
        }
    }
    
    // MARK: - Cart
    
    var totalCost: Double {
        return cartManager.totalCost
    }
    
    func addToCart(product: Product) {
        cartManager.addItem(product: product)
    }
    
    func removeFromCart(product: Product) {
        cartManager.removeItem(product: product)
    }
    
    func getQuantity(for product: Product) -> Int {
        return cartManager.getQuantity(for: product)
    }
    
    func updateQuantity(for product: Product, quantity: Int) {
        
        let currentQuantity = cartManager.getQuantity(for: product)
        
        if quantity == 0 {
            cartManager.removeItem(product: product)
        } else if quantity < currentQuantity {
            cartManager.removeItem(product: product)
        } else if quantity > currentQuantity {
            cartManager.addItem(product: product)
        } else {
            print("The quantity has not changed, nothing is required.")
        }
    }
    
    // MARK: - Other
    
    func reviewCountText(for count: Int) -> String {
        let lastDigit = count % 10
        let lastTwoDigits = count % 100
        
        if lastTwoDigits >= 11 && lastTwoDigits <= 19 {
            return "\(count) отзывов"
        } else if lastDigit == 1 {
            return "\(count) отзыв"
        } else if lastDigit >= 2 && lastDigit <= 4 {
            return "\(count) отзыва"
        } else {
            return "\(count) отзывов"
        }
    }
    
}
