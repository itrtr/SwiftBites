import SwiftUI

struct TagView: View {
    var tags: [Tag]
    var body: some View {
        HStack {
            ForEach(tags) { tag in
                HStack {
                    Image(systemName: tag.image)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.blue)
                    Text(tag.text)
                        .font(.caption)
                        .padding(.leading, 4)
                }
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
            }
        }
    }
}

//#Preview {
//    TagView()
//}
