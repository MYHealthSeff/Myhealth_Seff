import SwiftUI
import MapKit
import SwiftCSV

struct MySection_View: View {
    @State private var selectedSection: Int = 0 // State variable to track the selected section
    @State private var searchText: String = "" // State variable for search text
    @State private var showActionsOverlay: Bool = false // State variable for overlay visibility
    @State private var dragOffset = CGSize.zero // State variable to track drag offset
    
    // CSV Data and Filtered Patient Records
    @State private var patients: [PatientRecord] = []
    @State private var filteredPatients: [PatientRecord] = []
    
    var body: some View {
        ZStack {
            VStack {
                // Segmented Control for Sections
                Picker("Select Section", selection: $selectedSection) {
                    Text("A").tag(0)
                    Text("B").tag(1)
                    Text("C").tag(2)
                    Text("D").tag(3)
                    Text("E").tag(4)
                    Text("F").tag(5)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Enhanced Search Bar with Modern Look
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.95, green: 0.96, blue: 0.96))
                            .frame(height: 40) // Updated height for modern look
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search by patient name...", text: $searchText, onCommit: {
                                filterPatients() // Filter patients when search is submitted
                            })
                            .textFieldStyle(PlainTextFieldStyle())
                            .frame(height: 40)
                            .padding(.horizontal, 8)
                            
                            if !searchText.isEmpty {
                                Button(action: {
                                    searchText = ""
                                    filterPatients() // Reset search
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 8)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                }
                
                // Section Details
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("SECTION \(sectionName(selectedSection))")
                            .font(.title2)
                            .padding(.top)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Total Beds: \(totalRooms(for: selectedSection))")
                                    .font(.headline)
                                Text("Available Beds: \(availableBeds(for: selectedSection))")
                                    .font(.subheadline)
                                Text("Occupied Beds: \(occupiedBeds(for: selectedSection))")
                                    .font(.subheadline)
                            }
                            Spacer()
                            CircularProgressView(progress: occupancyRate(for: selectedSection))
                                .frame(width: 100, height: 100)
                        }
                        .padding(.horizontal)
                        
                        // Bed Details in Grid Layout
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                            ForEach(filteredPatients, id: \.room) { patient in
                                RoomTileView(patient: patient)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Google Maps View for Sections A and B
                        if selectedSection == 0 || selectedSection == 1 {
                            Text("Incoming EMS Patients")
                                .font(.title3)
                                .padding(.vertical)
                            
                            MapView()
                                .frame(height: 200)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // Draggable Sticky Button for Actions Overlay
            Button(action: {
                showActionsOverlay.toggle()
            }) {
                Image(systemName: "arrow.forward.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
            .offset(dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { _ in
                        if dragOffset.width > UIScreen.main.bounds.width - 100 {
                            dragOffset.width = UIScreen.main.bounds.width - 100
                        } else if dragOffset.width < 0 {
                            dragOffset.width = 0
                        }
                        if dragOffset.height > UIScreen.main.bounds.height - 150 {
                            dragOffset.height = UIScreen.main.bounds.height - 150
                        } else if dragOffset.height < 0 {
                            dragOffset.height = 0
                        }
                    }
            )
            .position(x: UIScreen.main.bounds.width - 60, y: UIScreen.main.bounds.height - 100)
            .sheet(isPresented: $showActionsOverlay) {
                ActionsOverlayView()
            }
        }
        .onAppear {
            loadPatientData() // Load CSV data on view appear
        }
        .navigationTitle("MySection & Rooms")
    }
    private func loadPatientData() {
        do {
            // Ensure the file is included in the project bundle
            guard let csvFilePath = Bundle.main.path(forResource: "database", ofType: "csv") else {
                print("CSV file not found")
                return
            }
            
            let csvURL = URL(fileURLWithPath: csvFilePath)
            let csv = try CSV(url: csvURL, delimiter: ",") // Specify the delimiter explicitly if needed
            
            // Parse the CSV rows
            patients = csv.namedRows.compactMap { row in
                guard let room = row["Room"],
                      let firstName = row["First Name"],
                      let lastName = row["Last Name"],
                      let condition = row["Condition"] else {
                    return nil
                }
                return PatientRecord(room: room, firstName: firstName, lastName: lastName, condition: condition)
            }
            filteredPatients = patients // Show all patients by default
        } catch {
            print("Failed to load CSV data: \(error)")
        }
    }

    // Filter patients based on search query
    private func filterPatients() {
        if searchText.isEmpty {
            filteredPatients = patients // Show all if no search text
        } else {
            filteredPatients = patients.filter {
                $0.firstName.lowercased().contains(searchText.lowercased()) ||
                $0.lastName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    // Helper functions to provide data for each section
    private func sectionName(_ index: Int) -> String {
        let sections = ["Critical Care", "Acute Care", "Intermediate Care", "Observation", "Emergency Room", "Fast Track"]
        return sections[index]
    }
    
    private func totalRooms(for section: Int) -> Int {
        let rooms = [18, 16, 14, 12, 14, 10]
        return rooms[section]
    }
    
    private func availableBeds(for section: Int) -> Int {
        return Int.random(in: 2...totalRooms(for: section))
    }
    
    private func occupiedBeds(for section: Int) -> Int {
        return totalRooms(for: section) - availableBeds(for: section)
    }
    
    private func occupancyRate(for section: Int) -> Double {
        let totalBeds = Double(totalRooms(for: section))
        let occupied = Double(occupiedBeds(for: section))
        return occupied / totalBeds
    }
}

struct RoomTileView: View {
    var patient: PatientRecord
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(patient.room)
                .font(.headline)
            Text("\(patient.firstName) \(patient.lastName)")
                .font(.subheadline)
            Text(patient.condition)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct PatientRecord {
    var room: String
    var firstName: String
    var lastName: String
    var condition: String
}

struct ActionsOverlayView: View {
    var body: some View {
        Text("Actions Overlay View")
            .font(.title)
            .padding()
    }
}

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Configure the map view if needed
    }
}

struct CircularProgressView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(Color.blue)
            
            Circle()
                .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: -90))
                .animation(.easeInOut, value: progress)
            
            Text(String(format: "%.0f%%", min(progress, 1.0) * 100))
                .font(.caption)
                .bold()
        }
    }
}
