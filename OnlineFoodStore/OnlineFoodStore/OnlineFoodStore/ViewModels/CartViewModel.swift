
import SwiftUI
import Combine

class CartViewModel: ObservableObject {
    
    // MARK: - Preperties
    
    @Published var items: [CartItem] = []
    private var cartManager: CartManaging
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - init
    
    init(cartManager: CartManaging) {
        self.cartManager = cartManager
        self.items = cartManager.getAllItems()
        
        if let cartManager = cartManager as? CartManager {
            cartManager.objectWillChange
                .sink { [weak self] _ in
                    self?.items = cartManager.getAllItems()
                }
                .store(in: &cancellables)
        }
    }
    
    var totalItems: Int {
        return cartManager.totalItems
    }
    
    var totalCost: Double {
        return cartManager.totalCost
    }
    
    func addItem(_ product: Product) {
        cartManager.addItem(product: product)
        items = cartManager.getAllItems()
    }
    
    func removeItem(_ product: Product) {
        cartManager.removeItem(product: product)
        items = cartManager.getAllItems()
    }
    
}
