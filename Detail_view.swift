import SwiftUI

struct Detail_view: View {
    let title: String
    let details: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 10)
            
            ForEach(details, id: \.self) { detail in
                Text(detail)
                    .padding(.bottom, 5)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(title)
    }
}
