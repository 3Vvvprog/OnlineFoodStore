
import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.totalItems > 0 {
                    List {
                        ForEach(viewModel.items, id: \.product.id) { cartItem in
                            HStack {
                                Text(cartItem.product.basicInfo.name)
                                    .font(.headline)
                                Spacer()
                                Text("\(cartItem.quantity) x")
                                    .font(.subheadline)
                                Text("\(cartItem.product.finalPrice, specifier: "%.2f") ₽")
                                    .font(.subheadline)
                                Spacer()
                                Button(action: {
                                    viewModel.removeItem(cartItem.product)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                        .background(Color.clear)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .contentShape(Rectangle())
                                Button(action: {
                                    viewModel.addItem(cartItem.product)
                                }) {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.green)
                                        .background(Color.clear)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .contentShape(Rectangle())
                            }
                            .contentShape(Rectangle())
                        }
                    }
                    HStack {
                        Text("Total: ")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(viewModel.totalCost, specifier: "%.2f") ₽")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding()
                    Button(action: {
                        // Here will be the action when placing an order
                    }) {
                        Text("Оплатить")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                } else {
                    Text("Товаров в корзине нет")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                }
            }
            .navigationTitle("Корзина")
        }
    }
    
}


#Preview {
    let cartManager = CartManager()
    let testProduct1 = Product(
        id: UUID(),
        basicInfo: BasicInfo(name: "Test Product 1", imageName: URL(string: "https://www.lebedevapps.com/demoapps/spar/images/1.png")!, country: nil, cachedImage: nil),
        pricing: Pricing(price: 100, discount: nil),
        measurement: Measurement(unitType: .piece, hasWeightOption: false, weight: nil),
        additionalInfo: AdditionalInfo(isFavorite: false, badge: ""),
        review: Review(rating: 4.5, reviewCount: 10)
    )
    let testProduct2 = Product(
        id: UUID(),
        basicInfo: BasicInfo(name: "Test Product 2", imageName: URL(string: "https://www.lebedevapps.com/demoapps/spar/images/1.png")!, country: nil, cachedImage: nil),
        pricing: Pricing(price: 200, discount: nil),
        measurement: Measurement(unitType: .piece, hasWeightOption: false, weight: nil),
        additionalInfo: AdditionalInfo(isFavorite: false, badge: ""),
        review: Review(rating: 4.0, reviewCount: 5)
    )
    cartManager.addItem(product: testProduct1)
    cartManager.addItem(product: testProduct2)
    let cartViewModel = CartViewModel(cartManager: cartManager)
    return CartView(viewModel: cartViewModel)
}
