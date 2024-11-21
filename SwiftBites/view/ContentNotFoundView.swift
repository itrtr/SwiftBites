import SwiftUI

struct ContentNotFoundView: View {
    var labelText: String
    var descriptionText: String
    var systemImageName: String
    
    var body: some View {
        ContentUnavailableView {
            Label(labelText, systemImage: systemImageName)
        } description: {
            Text(descriptionText)
        }
    }
}
