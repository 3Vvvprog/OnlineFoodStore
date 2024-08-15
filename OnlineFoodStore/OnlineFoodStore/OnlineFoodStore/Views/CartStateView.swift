
import SwiftUI

struct CartStateView: View {
    
    @Binding var quantity: Int
    var increment: () -> Void
    var decrement: () -> Void
    var originalPrice: Double
    var priceWithDiscount: Double
    var topPadding: CGFloat
    
    var body: some View {
        if quantity > 0 {
            HStack {
                Button(action: decrement) {
                    Image("minus")
                        .padding([.horizontal, .vertical], 10)
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
                VStack(spacing: 2) {
                    Text("\(quantity) кг")
                        .font(Font.custom("CeraRoundPro-Bold", size: 16))
                        .foregroundStyle(.white)
                    Text("~\(Double(quantity) * priceWithDiscount, specifier: "%.2f") ₽")
                        .font(.custom("SFProDisplay-Regular", size: 12))
                        .foregroundStyle(.white)
                }
                Spacer()
                Button(action: increment) {
                    Image("plus")
                        .padding([.horizontal, .vertical], 10)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .background(Color.brandedGreen)
            .cornerRadius(40)
            .padding(.horizontal, 8)
            .padding(.top, topPadding)
            .padding(.bottom, 4)
        } else {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: 4) {
                        Text("\(priceWithDiscount, specifier: "%.0f")")
                            .font(Font.custom("CeraRoundPro-Bold", size: 20))
                        Text("\(priceWithDiscount, specifier: "%.0f")")
                            .font(Font.custom("CeraRoundPro-Bold", size: 16))
                            .baselineOffset(4)
                        HStack(spacing: -3) {
                            Text("₽")
                                .font(Font.custom("CeraRoundPro-Bold", size: 12))
                                .baselineOffset(10)
                            Text("/")
                                .font(Font.custom("CeraRoundPro-Bold", size: 12))
                            Text("кг")
                                .font(Font.custom("CeraRoundPro-Bold", size: 12))
                                .baselineOffset(-10)
                        }
                    }
                    
                    Text("\(originalPrice, specifier: "%.1f" )")
                        .font(.custom("SFProDisplay-Regular", size: 12))
                        .foregroundColor(.customGray)
                        .strikethrough(true, color: .customGray)
                }
                Spacer()
                Button(action: increment) {
                    HStack {
                        Image("shoppingCart")
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.brandedGreen)
                    .cornerRadius(40)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 8)
            .padding(.top, topPadding)
            .padding(.bottom, 4)
        }
    }
    
}

// MARK: - Preview

#Preview("Quantity 0 Example") {
    StatefulPreviewWrapper(0) { quantity in
        AnyView(
            CartStateView(
                quantity: quantity,
                increment: { quantity.wrappedValue += 1 },
                decrement: { quantity.wrappedValue -= 1 }, 
                originalPrice: 129,
                priceWithDiscount: 89, 
                topPadding: 12
            )
            .frame(width: 170)
            .background(Color.gray)
        )
    }
}

#Preview("Quantity 1 Example") {
    StatefulPreviewWrapper(1) { quantity in
        AnyView(
            CartStateView(
                quantity: quantity,
                increment: { quantity.wrappedValue += 1 },
                decrement: { quantity.wrappedValue -= 1 }, 
                originalPrice: 129,
                priceWithDiscount: 89,
                topPadding: 12
            )
            .frame(width: 170)
            .background(Color.gray)
        )
    }
}

struct StatefulPreviewWrapper<Value>: View {
    
    @State private var value: Value
    private let content: (Binding<Value>) -> AnyView
    
    init(_ initialValue: Value, content: @escaping (Binding<Value>) -> AnyView) {
        _value = State(wrappedValue: initialValue)
        self.content = content
    }
    
    var body: some View {
        content($value)
    }
    
}
