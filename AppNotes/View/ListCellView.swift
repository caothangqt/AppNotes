import SwiftUI

struct ListCellView: View {
    var note: Entity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(note.title ?? "New Note")
                .lineLimit(1)
                .font(.title3)
                .fontWeight(.bold)
            Text(note.content ?? "No context available")
                .lineLimit(1)
                .fontWeight(.light)
        }
    }
}
