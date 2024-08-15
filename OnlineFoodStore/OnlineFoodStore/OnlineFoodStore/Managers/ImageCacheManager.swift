

import SwiftUI

class ImageCacheManager: ObservableObject {
    
    @Published private var cache: [URL: Image] = [:]
    
    func imageView(for url: URL) -> AnyView {
        if let cachedImage = cache[url] {
            return AnyView(cachedImage.resizable().scaledToFit())
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let uiImage = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        let placeholder = Image("noPhoto")
                        self.cache[url] = placeholder
                        self.objectWillChange.send()
                    }
                    return
                }
                let image = Image(uiImage: uiImage)
                DispatchQueue.main.async {
                    self.cache[url] = image
                    self.objectWillChange.send()
                }
            }.resume()
            return AnyView(
                Image("loadingPhoto")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .overlay {
                        ProgressView()
                            .progressViewStyle(CustomCircularProgressViewStyle())
                    }
            )
        }
    }
    
}
