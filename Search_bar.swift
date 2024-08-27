import SwiftUI

struct Search_bar: View {
    @Binding var text: String
    @State private var isEditing = false

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search...", text: $text, onEditingChanged: { editing in
                    isEditing = editing
                })
                .padding(7)
                .foregroundColor(.primary)
                .background(
                    RoundedRectangle(cornerRadius: 20) 
                        .strokeBorder(Color.gray.opacity(0.3), lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(isEditing ? Color.white.opacity(0.1) : Color.clear)
                        )
                )
                .overlay(
                    HStack {
                        Spacer()
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .shadow(radius: isEditing ? 5 : 0)
            
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .frame(maxWidth: .infinity, alignment: .leading) // topLalignment
    }
}
