import SwiftUI

struct ScrollIndicatorView: View {
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
