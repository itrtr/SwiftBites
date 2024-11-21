import SwiftUI

//This view is responsible for providing the scroll view functionality of the passed images
//The client can conditionally choose whether to allow auto-scroll or manual scroll with index view
struct ImageScrollerView: View {
    @State private var selectedImageIndex = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let autoScroll: Bool
    let images: [String]
    
    init(images: [String] = ["uk", "us", "germany", "italy", "russia", "spain", "estonia"], autoScroll: Bool = false) {
        self.autoScroll = autoScroll
        self.images = images
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                TabView(selection: $selectedImageIndex) {
                    ForEach(0..<images.count, id: \.self) { imageIndex in
                        Image(images[imageIndex])
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .clipped()
                            .tag(imageIndex)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        PageIndicator(currentIndex: $selectedImageIndex, totalCount: images.count).padding(.bottom, 10)
                        Spacer()
                        
                    }
                }
            }
            .frame(height: 200)
        }
        .onReceive(timer) { _ in
            if autoScroll {
                withAnimation {
                    selectedImageIndex = (selectedImageIndex + 1) % images.count
                }
            }
        }
    }
}

struct PageIndicator: View {
    @Binding var currentIndex: Int
    let totalCount: Int
    
    var body: some View {
        HStack {
            ForEach(0..<totalCount, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color.blue : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
    }
}


#Preview {
    ImageScrollerView()
}
