

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var cartManager: CartManager
    @StateObject var productListViewModel: ProductListViewModel
    @StateObject var cartViewModel: CartViewModel
    
    init(cartManager: CartManager) {
        _productListViewModel = StateObject(wrappedValue: ProductListViewModel(cartManager: cartManager))
        _cartViewModel = StateObject(wrappedValue: CartViewModel(cartManager: cartManager))
    }
    
    // MARK: - Body
    
    var body: some View {
        makeUI()
    }
    
    // MARK: - UI
    
    private func makeUI() -> some View {
        TabView {
            ProductListView(viewModel: productListViewModel)
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Товары")
                }
            
            FavoritesView(viewModel: FavoritesViewModel(productListViewModel: productListViewModel))
                .tabItem {
                    Image(systemName: "heart")
                    Text("Избранное")
                }
            
            CartView(viewModel: cartViewModel)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Корзина")
                }
            
            DummyView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Заказы")
                }
        }
    }
    
}

// MARK: - Preview

#Preview {
    let cartManager = CartManager()
    return ContentView(cartManager: cartManager)
        .environmentObject(cartManager)
        .environmentObject(ImageCacheManager())
}
