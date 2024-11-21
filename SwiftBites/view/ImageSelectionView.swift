import PhotosUI
import SwiftUI

struct ImageSelectionView: View {
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var isPickerPresented = false
    @State private var selectedImageIndex = 0
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    private let autoScroll: Bool = true
    
    @Binding var images: [Image]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if images.isEmpty {
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                        Text("Select Images")
                            .font(.headline)
                        Spacer()
                    }
                    .onTapGesture {
                        isPickerPresented = true
                    }
                } else {
                    ZStack(alignment: .bottom) {
                        TabView(selection: $selectedImageIndex) {
                            ForEach(0..<images.count, id: \.self) { imageIndex in
                                images[imageIndex]
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: Constants.imageSetHeight)
                                    .cornerRadius(10)
                                    .clipped()
                                    .tag(imageIndex)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        
                        ScrollIndicatorView(currentIndex: $selectedImageIndex, totalCount: images.count)
                            .padding(.bottom, 10)
                            .background(
                                Color.black.opacity(0.3)
                                    .cornerRadius(5, antialiased: true)
                            )
                    }
                    .onReceive(timer) { _ in
                        if autoScroll {
                            withAnimation {
                                selectedImageIndex = (selectedImageIndex + 1) % images.count
                            }
                        }
                    }
                    .onTapGesture {
                        isPickerPresented = true
                    }
                }
            }
        }.padding(0)
            .photosPicker(isPresented: $isPickerPresented, selection: $selectedItems, matching: .images)
            .onChange(of: selectedItems) {
                Task {
                    images.removeAll()
                    for item in selectedItems {
                        if let image = try? await item.loadTransferable(type: Image.self) {
                            images.append(image)
                        }
                    }
                }
            }
    }
}
