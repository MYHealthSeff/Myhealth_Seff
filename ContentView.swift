import SwiftUI

struct ContentView: View {
    // Define the grid layout with 4 columns
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    @State private var searchText: String = "" // State variable for search text

    var body: some View {
        NavigationView {
            ZStack {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.45, green: 0.55, blue: 0.55),
                        Color(red: 0.38, green: 0.82, blue: 0.64).opacity(0)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .edgesIgnoringSafeArea(.all) // Extend the gradient to cover the entire screen
                
                // Main content
                VStack {
                    // Header with an Image and a Title
                    HStack {
                        Image("MyHealth.AI Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50) // Adjust size as needed
                            .padding()
                        
                        Spacer()
                        
                        NavigationLink(destination: DashboardView()) {
                            Image(systemName: "desktopcomputer")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 33, height: 33) // Adjust size as needed
                                .padding()
                        }
                    }
                    
                    // Search Bar
                    HStack {
                        SearchBar(text: $searchText)
                            .padding()
                    }
                    .padding(.top, -50) // Adjust spacing as needed
                    
                    // Main Content with Grid of Buttons
                    LazyVGrid(columns: columns, spacing: 30) {
                        NavigationLink(destination: MySection_view()) {
                            IconWithText(iconName: "house.fill", labelText: "MySection & Rooms")
                        }
                        NavigationLink(destination: Messages_view()) {
                            IconWithText(iconName: "message.fill", labelText: "Messages")
                        }
                        NavigationLink(destination: Critical_care_view()) {
                            IconWithText(iconName: "bell.fill", labelText: "Critical Care Watch")
                        }
                        NavigationLink(destination: Status_view()) {
                            IconWithText(iconName: "doc.text.fill", labelText: "Status Updates")
                        }
                        NavigationLink(destination: ToolsDevices_view()) {
                            IconWithText(iconName: "wrench.fill", labelText: "Tools & Devices")
                        }
                        NavigationLink(destination: ManagementSchedules_view()) {
                            IconWithText(iconName: "calendar.fill", labelText: "Management & Schedules")
                        }
                        NavigationLink(destination: MyTeams_view()) {
                            IconWithText(iconName: "person.3.fill", labelText: "My Teams & Residents")
                        }
                        NavigationLink(destination: NewsInfo_view()) {
                            IconWithText(iconName: "newspaper.fill", labelText: "News & More Info")
                        }
                    }
                    .padding()

                    
                    // Footer with NavigationLink
                    Spacer()
                    
                    NavigationLink(destination: PatientDetailsView()) {
                        Text("MyPatients")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.blue)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                    .padding()
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search..."
        searchBar.autocapitalizationType = .none
        searchBar.backgroundImage = UIImage() // Remove background color
        searchBar.keyboardType = .default // Enable default keyboard
        searchBar.returnKeyType = .search // Display the search key on the keyboard
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

struct PatientDetailsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Patient Chart")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
                
                HStack {
                    NavigationLink(destination: DetailView(title: "Patient Information", details: patientInformationDetails)) {
                        IconWithText(iconName: "person.fill", labelText: "Patient Information")
                    }
                    
                    NavigationLink(destination: DetailView(title: "Medical History", details: medicalHistoryDetails)) {
                        IconWithText(iconName: "heart.text.square.fill", labelText: "Medical History")
                    }
                }
                
                HStack {
                    NavigationLink(destination: DetailView(title: "Current Medications", details: currentMedicationsDetails)) {
                        IconWithText(iconName: "pills.fill", labelText: "Current Medications")
                    }
                    
                    NavigationLink(destination: DetailView(title: "Ongoing Care Plan", details: ongoingCarePlanDetails)) {
                        IconWithText(iconName: "waveform.path.ecg", labelText: "Ongoing Care Plan")
                    }
                }
                
                HStack {
                    NavigationLink(destination: DetailView(title: "Orders/Results", details: ordersResultsDetails)) {
                        IconWithText(iconName: "doc.text.fill", labelText: "Orders/Results")
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

struct DetailView: View {
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

struct IconWithText: View {
    let iconName: String
    let labelText: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding()
                .background(Color.white.opacity(0.2)) // Background for the icon
                .cornerRadius(6) // Rounded corners
            Text(labelText)
                .font(.system(size: 10)) // Smaller font size
                .multilineTextAlignment(.center) // Center text
                .foregroundColor(.white) // White text color
                .padding(.top, 4) // Space between icon and text
        }
        .frame(width: 80, height: 80) // Adjusted size for better spacing
        .background(Color.clear) // Remove background color
        .padding()
    }
}

struct DashboardView: View {
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        VStack {
            Text("Dashboard")
            Text("Dashboard")
                .font(.largeTitle)
                .padding()
            
            LazyVGrid(columns: columns, spacing: 20) {
                NavigationLink(destination: Text("Detail for Total Active Patients")) {
                    IconWithText(iconName: "person.fill", labelText: "Total Active Patients\n\(Int.random(in: 50...100))")
                }
                NavigationLink(destination: Text("Detail for Avg. Wait Time")) {
                    IconWithText(iconName: "clock.fill", labelText: "Avg. Wait Time\n15 mins")
                }
                NavigationLink(destination: Text("Detail for Time to PIA")) {
                    IconWithText(iconName: "clock.arrow.circlepath", labelText: "Time to PIA\n10 mins")
                }
                NavigationLink(destination: Text("Detail for Admitted")) {
                    IconWithText(iconName: "checkmark.circle.fill", labelText: "Admitted\n\(Int.random(in: 30...50))")
                }
                NavigationLink(destination: Text("Detail for Discharged")) {
                    IconWithText(iconName: "xmark.circle.fill", labelText: "Discharged\n\(Int.random(in: 10...30))")
                }
                NavigationLink(destination: Text("Detail for Total Visits")) {
                    IconWithText(iconName: "waveform.path.ecg", labelText: "Total Visits\n\(Int.random(in: 60...87))")
                }
                NavigationLink(destination: Text("Detail for Section Capacity")) {
                    IconWithText(iconName: "gauge", labelText: "Section Capacity\n\(Int.random(in: 60...100))%")
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
