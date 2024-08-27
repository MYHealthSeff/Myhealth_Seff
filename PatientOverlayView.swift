import SwiftUI

struct PatientOverlayView: View {
    var body: some View {
        ZStack {
            VStack {
                // Patient Image and Info
                HStack {
                    AsyncImage(url: URL(string: "https://via.placeholder.com/76x74"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 76, height: 74)
                        .padding(.trailing, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Patient Name")
                            .font(.headline)
                        Text("Examination table has been sanitized - Ready and available.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("2 minutes ago")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 10)
                    
                    Spacer()
                }
                .padding()
                
                // Patient Notes
                VStack(alignment: .leading, spacing: 10) {
                    Text("Patient has returned to RoomD14")
                        .font(.body)
                        .padding(.bottom, 5)
                    Text("30 minutes ago")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("Patient has been moved to Room A23 for immediate care.")
                        .font(.body)
                        .padding(.top, 5)
                }
                .padding()
                
                // Actions and Buttons
                HStack {
                    Button(action: {
                        // Handle RX sent to pharmacy
                    }) {
                        Text("Send RX to Pharmacy")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // Handle email copy to doctor
                    }) {
                        Text("Email Copy to Doctor")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Spacer()
                }
                .padding()
                
                // Confirmation Notification
                VStack {
                    Button(action: {
                        // Handle discharge confirmation
                    }) {
                        Text("Confirm Discharge")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    Text("Discharge confirmation will update the department's status and capacity.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4))
        .edgesIgnoringSafeArea(.all)
    }
}
