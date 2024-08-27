import SwiftUI

struct mainview_controller: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            // Search Bar
            HStack {
                Search_bar(text: $searchText)
                    .padding()
            }
        }
    }
}
