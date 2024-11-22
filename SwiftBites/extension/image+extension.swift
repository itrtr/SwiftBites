import SwiftUI

extension Image {
    // Convert SwiftUI Image to Data
    @MainActor func saveAsData(compressionQuality: CGFloat = 0.8) -> Data? {
        let renderer = ImageRenderer(content: self)
        guard let uiImage = renderer.uiImage else { return nil }
        
        // Convert to JPEG with optional compression quality
        return uiImage.jpegData(compressionQuality: compressionQuality)
    }
    
    // Create Image from Data with scaling options
    init?(data: Data,
          contentMode: ContentMode = .fill,
          scale: CGFloat = 1.0) {
        guard let uiImage = UIImage(data: data) else { return nil }
        self.init(uiImage: uiImage)
    }
}
