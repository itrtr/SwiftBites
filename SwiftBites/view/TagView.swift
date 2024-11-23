import SwiftUI

struct TagSubView: View {
    var imageName: String
    var textName: String
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.blue)
            Text(textName)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.leading, 4)
        }
        .padding(6)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(8)
    }
}

struct TagView: View {
    var categoryName: String
    var servingSize: Int
    var servingTime: Int
    var body: some View {
        HStack {
            TagSubView(imageName: "tag", textName: categoryName)
            TagSubView(imageName: "clock", textName: String(servingTime))
            TagSubView(imageName: "person", textName: String(servingTime))
        }
    }
}
