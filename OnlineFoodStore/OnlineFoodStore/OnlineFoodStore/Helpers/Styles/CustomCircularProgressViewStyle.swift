
import SwiftUI

struct CustomCircularProgressViewStyle: ProgressViewStyle {
    
    var lineWidth: CGFloat = 20.0
    var size: CGFloat = 100.0
    var color: Color = .customGreen
    @State private var isAnimating: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.3), lineWidth: lineWidth)
                .frame(width: size, height: size)
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(color, lineWidth: lineWidth)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .frame(width: size, height: size)
                .onAppear {
                    isAnimating = true
                }
                .animation(Animation.linear(duration: 0.75).repeatForever(autoreverses: false), value: isAnimating)
        }
    }
    
}

struct ProgressViewPreview: View {
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CustomCircularProgressViewStyle())
    }
    
}

#Preview {
    ProgressViewPreview()
}
