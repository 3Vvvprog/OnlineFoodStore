

import Foundation
import SwiftUI

struct ProductResponse: Codable {
    let products: [Product]
}

struct Product: Identifiable, Codable {
    var id: UUID
    var basicInfo: BasicInfo
    var pricing: Pricing
    var measurement: Measurement
    var additionalInfo: AdditionalInfo
    var review: Review
    
    var finalPrice: Double {
        if let discount = pricing.discount {
            return pricing.price - (pricing.price * discount / 100)
        } else {
            return pricing.price
        }
    }
}

struct BasicInfo: Codable {
    var name: String
    var imageName: URL
    var country: String?
    var cachedImage: Image?
    
    private enum CodingKeys: String, CodingKey {
        case name, imageName, country
    }
}

struct Pricing: Codable {
    var price: Double
    var discount: Double?
}

struct Measurement: Codable {
    var unitType: UnitType
    var hasWeightOption: Bool
    var weight: String?
    
    enum UnitType: String, Codable {
        case piece = "Шт"
        case kilogram = "Кг"
    }
}

struct AdditionalInfo: Codable {
    var isFavorite: Bool
    var badge: String
}

struct Review: Codable {
    var rating: Double
    var reviewCount: Int
}
