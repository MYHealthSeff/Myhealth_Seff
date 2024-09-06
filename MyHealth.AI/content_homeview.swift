import SwiftUI
import SwiftCSV

@main
struct Main_App: App {
    var body: some Scene {
        WindowGroup {
            content_homeview() // Entry point for the app
        }
    }
}

struct content_homeview: View {
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    @State private var searchText: String = ""
    @State private var patients: [[String: String]] = [] // Array to store patients from the CSV

    var filteredPatients: [[String: String]] {
        if searchText.isEmpty {
            return patients
        } else {
            return patients.filter { patient in
                patient["First_Name"]?.contains(searchText) == true ||
                patient["Last_Name"]?.contains(searchText) == true
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Your existing gradient and layout code
                
                VStack {
                    // Header, search bar, grid, and other UI components

                    Spacer()
                    
                    HStack(spacing: 40) {
                        // Your existing navigation links for dashboard and other views
                    }
                    .padding()
                }
                .navigationBarHidden(true)
            }
        }
        .onAppear {
            // Check the CSV file path and load the CSV
            if let path = Bundle.main.path(forResource: "database", ofType: "csv") {
                print("CSV file path: \(path)") // Print path to the Xcode console
            } else {
                print("CSV file not found.")
            }
            loadCSV() // Load the CSV data after checking the path
        }
    }

    // Function to load CSV
    func loadCSV() {
        if let path = Bundle.main.path(forResource: "database", ofType: "csv") {
            do {
                let csv = try CSV<<#DataView: CSVView#>>(url: URL(fileURLWithPath: path)) // Load the CSV file
                patients = csv.namedRows // Store CSV rows as dictionaries

                // Check and print the first row to validate the CSV structure
                if let firstRow = patients.first {
                    print("First row of CSV: \(firstRow)")
                }
            } catch {
                print("Error reading CSV: \(error)") // Handle CSV loading error
            }
        }
    }
}

