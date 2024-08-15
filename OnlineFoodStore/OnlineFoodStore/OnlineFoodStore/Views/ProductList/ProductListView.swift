

import SwiftUI

struct ProductListView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var imageCacheManager: ImageCacheManager
    @ObservedObject var viewModel: ProductListViewModel
    @State var isGrid = true
    private let gridLayout: [GridItem] = Array(repeating: .init(.adaptive(minimum: 100, maximum: 200), spacing: 5, alignment: .center), count: 2)
    private let shadowColor = Color(red: 0.55, green: 0.55, blue: 0.55).opacity(0.2)
    
    // MARK: - Body
    
    var body: some View {
        makeUI()
    }
    
    // MARK: - UI
    
    private func makeUI() -> some View {
        NavigationView {
            Group {
                if isGrid {
                    ScrollView {
                        LazyVGrid(columns: gridLayout, spacing: 8) {
                            ForEach(viewModel.products, id: \.id) { product in
                                productGridCell(product)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                    }
                } else {
                    List(viewModel.products, id: \.id) { product in
                        let isLast = product.id == viewModel.products.last?.id
                        productListCell(product, isLast: isLast)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                    }
                    .listStyle(.plain)
                    .padding(.top, 12)
                }
            }
            .toolbar {
                createToolBar()
            }
        }
    }
    
    private func createToolBar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { isGrid.toggle() }) {
                Image(isGrid ? "grid" : "list")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
    
    private func productGridCell(_ product: Product) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            imageCacheManager.imageView(for: product.basicInfo.imageName)
                .frame(maxWidth: .infinity, maxHeight: 168)
                .overlay(alignment: .topLeading) {
                    ProductBadge(type: product.additionalInfo.badge)
                }
                .overlay(alignment: .topTrailing) {
                    FavouriteSection(isFavorite: product.additionalInfo.isFavorite) {
                        viewModel.toggleFavorite(product: product)
                    }
                }
                .overlay(alignment: .bottomLeading) {
                    RatingAndDiscountRow(rating: product.review.rating, discount: product.pricing.discount)
                }
            VStack(alignment: .leading, spacing: 0) {
                Text(product.basicInfo.name)
                    .font(Font.custom("SFProDisplay-Regular", size: 12))
                    .lineLimit(2, reservesSpace: true)
                    .padding([.top, .horizontal], 8)
                CountrySection(productCountry: product.basicInfo.country)
                
                CartStateView(
                    quantity: Binding(
                        get: { viewModel.getQuantity(for: product) },
                        set: { newQuantity in
                            viewModel.updateQuantity(for: product, quantity: newQuantity)
                        }
                    ),
                    increment: {
                        viewModel.addToCart(product: product)
                    },
                    decrement: {
                        viewModel.removeFromCart(product: product)
                    },
                    originalPrice: product.pricing.price,
                    priceWithDiscount: product.finalPrice,
                    topPadding: 12
                )
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: shadowColor, radius: 4)
    }
    
    private func productListCell(_ product: Product, isLast: Bool) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 4) {
                imageCacheManager.imageView(for: product.basicInfo.imageName)
                    .frame(width: 144, height: 144)
                    .overlay(alignment: .topLeading) {
                        ProductBadge(type: product.additionalInfo.badge)
                    }
                    .overlay(alignment: .bottomTrailing) {
                        if let discountText = product.pricing.discount {
                            Text("\(discountText, specifier: "%.0f")%")
                                .font(Font.custom("CeraRoundPro-Bold", size: 16))
                                .foregroundStyle(Color.discountRed)
                        }
                    }
                VStack(alignment: .leading, spacing: 0) {
                    ReviewAndRatingRow(viewModel: viewModel, rating: product.review.rating, reviewCount: product.review.reviewCount)
                    Text(product.basicInfo.name)
                        .font(Font.custom("SFProDisplay-Regular", size: 12))
                        .lineLimit(2, reservesSpace: true)
                        .padding([.top, .horizontal], 8)
                    CountrySection(productCountry: product.basicInfo.country)
                    CartStateView(
                        quantity: Binding(
                            get: { viewModel.getQuantity(for: product) },
                            set: { newQuantity in
                                viewModel.updateQuantity(for: product, quantity: newQuantity)
                            }
                        ),
                        increment: {
                            viewModel.addToCart(product: product)
                        },
                        decrement: {
                            viewModel.removeFromCart(product: product)
                        },
                        originalPrice: product.pricing.price,
                        priceWithDiscount: product.finalPrice,
                        topPadding: 28
                    )
                }
                .overlay(alignment: .topTrailing) {
                    FavouriteSection(isFavorite: product.additionalInfo.isFavorite) {
                        viewModel.toggleFavorite(product: product)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 8))
            if !isLast {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundStyle(Color.customGray)
                    .padding(.vertical, 16)
            }
        }
    }
    
}

// MARK: - Preview

#Preview {
    let cartManager = CartManager()
    return ProductListView(viewModel: ProductListViewModel(cartManager: cartManager))
        .environmentObject(ImageCacheManager())
}
