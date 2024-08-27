import SwiftUI
import MapKit

struct MySection_View: View {
    @State private var selectedSection: Int = 0 // State variable to track the selected section
    @State private var searchText: String = "" // State variable for search text
    @State private var showActionsOverlay: Bool = false // State variable for overlay visibility
    @State private var dragOffset = CGSize.zero // State variable to track drag offset

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

                // Search Bar
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(red: 0.95, green: 0.96, blue: 0.96))
                            .frame(width: 318, height: 22)
                        TextField("Search...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(.horizontal, 8)
                            .frame(width: 300, height: 20)
                    }
                }
                .padding(.horizontal)

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
                            ForEach(bedStatus(for: selectedSection).keys.sorted(), id: \.self) { key in
                                RoomTileView(room: key, details: bedStatus(for: selectedSection)[key]!)
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

            // Draggable Sticky
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
        .navigationTitle("MySection & Rooms")
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

    private func bedStatus(for section: Int) -> [String: (String, String, String)] {
        let icons = ["bed", "chair", "timer", "lab", "radiology", "message"]
        let patients = [("John", "Doe"), ("Jane", "Smith"), ("Tom", "Johnson"), ("Sara", "Williams"), ("Mike", "Brown"), ("Anna", "Davis")]
        let reasons = ["Chest Pain", "Fracture", "Abdominal Pain", "Head Injury", "Fever", "Asthma Attack"]

        return Dictionary(uniqueKeysWithValues: (1...totalRooms(for: section)).map {
            ("Room \($0)", (icons.randomElement()!, patients[$0 % patients.count].0, patients[$0 % patients.count].1))
        })
    }
}

// Circular Progress View
struct CircularProgressView: View {
    var progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(.blue)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)

            Text(String(format: "%.0f%%", min(progress, 1.0) * 100.0))
                .font(.headline)
                .bold()
        }
    }
}

// Room Tile View
struct RoomTileView: View {
    var room: String
    var details: (String, String, String)

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(roomNumber(from: room))
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: details.0) // Vector icon
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            Spacer()
            HStack {
                Text("\(details.1) \(details.2)")
                    .font(.caption)
                    .foregroundColor(.black)
                Spacer()
            }
            Spacer()
            Text(reasonForVisit(for: details.1))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 2)
        )
        .frame(width: 100, height: 140) // Adjusted size
        .onTapGesture {
            // Navigate to Patient Chart view
            print("Navigating to \(details.1) \(details.2)'s Patient Chart")
        }
    }

    private func roomNumber(from room: String) -> String {
        return room.components(separatedBy: " ").last ?? ""
    }

    private func reasonForVisit(for firstName: String) -> String {
        // Placeholder for actual logic to match reason for visit based on the patient's first name
        let reasons = ["Chest Pain", "Fracture", "Abdominal Pain", "Head Injury", "Fever", "Asthma Attack"]
        return reasons.randomElement() ?? ""
    }
}

// Map View for EMS
struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.title = "Incoming Patient"
        annotation.subtitle = "Chest Pain, 45 Y, Male"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        view.addAnnotation(annotation)
        view.setRegion(MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
    }
}

// Actions Overlay View
struct ActionsOverlayView: View {
    var body: some View {
        VStack {
            Text("Quick Actions")
                .font(.title)
                .padding()

            Spacer()

            // Add your action buttons here
            Button(action: {
                print("Action 1 triggered")
            }) {
                Text("Action 1")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Button(action: {
                print("Action 2 triggered")
            }) {
                Text("Action 2")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
}
