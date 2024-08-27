import SwiftUI

struct Iconwith_text: View {
    let iconName: String
    let labelText: String
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(6) 
            Text(labelText)
                .font(.system(size: 10))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.top, 4)
        }
        .frame(width: 80, height: 80)
        .background(Color.clear)
        .padding()
    }
}
