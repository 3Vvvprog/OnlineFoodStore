

import Foundation

protocol CartManaging {
    var totalItems: Int { get }
    var totalCost: Double { get }
    func addItem(product: Product)
    func removeItem(product: Product)
    func getQuantity(for product: Product) -> Int
    func cost(for product: Product) -> Double
    func getAllItems() -> [CartItem]
}

class CartManager: ObservableObject, CartManaging {
    
    // Dictionary for managing the cart
    @Published private var items: [UUID: CartItem] = [:]
    
    var totalItems: Int {
        return items.values.reduce(0) { $0 + $1.quantity }
    }
    
    var totalCost: Double {
        return items.values.reduce(0) { $0 + $1.product.finalPrice * Double($1.quantity) }
    }
    
    func addItem(product: Product) {
        if let existingItem = items[product.id] {
            items[product.id] = CartItem(product: product, quantity: existingItem.quantity + 1)
        } else {
            items[product.id] = CartItem(product: product, quantity: 1)
        }
        objectWillChange.send()
    }
    
    func removeItem(product: Product) {
        guard let existingItem = items[product.id] else {
            print("Product not found in cart. Nothing to delete.")
            return
        }
        if existingItem.quantity > 1 {
            items[product.id] = CartItem(product: product, quantity: existingItem.quantity - 1)
        } else {
            items.removeValue(forKey: product.id)
        }
        objectWillChange.send()
    }
    
    func getQuantity(for product: Product) -> Int {
        return items[product.id]?.quantity ?? 0
    }
    
    func cost(for product: Product) -> Double {
        guard let item = items[product.id] else { return 0 }
        return item.product.finalPrice * Double(item.quantity)
    }
    
    func getAllItems() -> [CartItem] {
        return Array(items.values)
    }
    
}
