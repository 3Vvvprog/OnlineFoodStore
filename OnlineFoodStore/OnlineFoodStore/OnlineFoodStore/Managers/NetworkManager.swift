

import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchProducts(url: URL) -> AnyPublisher<ProductResponse, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ProductResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
