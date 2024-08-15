
import SwiftUI

@main
struct OnlineFoodStoreApp: App {
    
    @StateObject private var imageCacheManager = ImageCacheManager()
    @StateObject private var cartManager = CartManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(cartManager: cartManager)
                .environmentObject(imageCacheManager)
                .environmentObject(cartManager)
        }
    }
    
}
