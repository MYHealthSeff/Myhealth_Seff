import SwiftUI

struct Patientdetails_view: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Patient Chart")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
                
                HStack {
                    NavigationLink(destination: Detail_view(title: "Patient Information", details: patientInformationDetails)) {
                        Iconwith_text(iconName: "person.fill", labelText: "Patient Information")
                    }
                    
                    NavigationLink(destination: Detail_view(title: "Medical History", details: medicalHistoryDetails)) {
                        Iconwith_text(iconName: "heart.text.square.fill", labelText: "Medical History")
                    }
                }
                
                HStack {
                    NavigationLink(destination: Detail_view(title: "Current Medications", details: currentMedicationsDetails)) {
                        Iconwith_text(iconName: "pills.fill", labelText: "Current Medications")
                    }
                    
                    NavigationLink(destination: Detail_view(title: "Ongoing Care Plan", details: ongoingCarePlanDetails)) {
                        Iconwith_text(iconName: "waveform.path.ecg", labelText: "Ongoing Care Plan")
                    }
                }
                
                HStack {
                    NavigationLink(destination: Detail_view(title: "Orders/Results", details: ordersResultsDetails)) {
                        Iconwith_text(iconName: "doc.text.fill", labelText: "Orders/Results")
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Patient Details")
    }
    
    private let patientInformationDetails = [
        "Name: John Doe",
        "Age: 45",
        "Gender: Male",
        "Blood Type: O+"
    ]
    
    private let medicalHistoryDetails = [
        "Diagnosed Conditions:",
        "- Hypertension",
        "- Type 2 Diabetes",
        "- Asthma"
    ]
    
    private let currentMedicationsDetails = [
        "1. Metformin 500mg - Twice daily",
        "2. Lisinopril 20mg - Once daily",
        "3. Albuterol Inhaler - As needed"
    ]
    
    private let ongoingCarePlanDetails = [
        "1. Maintain a balanced diet, low in sugar and salt.",
        "2. Exercise for at least 30 minutes, five days a week.",
        "3. Monitor blood glucose levels daily.",
        "4. Regular follow-ups with the primary care physician every 3 months."
    ]
    
    private let ordersResultsDetails = [
        "1. Blood Test Results",
        "2. X-ray Results",
        "3. MRI Scan Results"
    ]
}
