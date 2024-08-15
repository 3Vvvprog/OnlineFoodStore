

import Foundation
import SwiftUI

enum ProductBadgeType: String {
    case new = "Новинки"
    case discount = "Удар по ценам"
    case cardPrice = "Цена по карте"
    case none = ""
    
    var color: Color {
        switch self {
        case .new:
            return Color.customBlue
        case .discount:
            return Color.customRed
        case .cardPrice:
            return Color.customGreen
        case .none:
            return Color.clear
        }
    }
}

enum Country: String {
    case russia = "Россия"
    case france = "Франция"
    case japan = "Япония"
    case poland = "Польша"
    case argentina = "Аргентина"
    
    var flagImageName: String {
        switch self {
        case .russia:
            return "🇷🇺"
        case .france:
            return "🇫🇷"
        case .japan:
            return "🇯🇵"
        case .poland:
            return "🇵🇱"
        case .argentina:
            return "🇦🇷"
        }
    }
}
