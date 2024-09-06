import SwiftUI
import SwiftCSV

struct SearchBarView: View {
    @State private var searchText: String = ""
    @State private var patients: [Patient] = []

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.95, green: 0.96, blue: 0.96))
                        .frame(height: 40)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search by patient name...", text: $searchText, onCommit: {
                            filterPatients()
                        })
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(height: 40)
                        .padding(.horizontal, 8)
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                                filterPatients()
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
            
            // List of filtered patients
            List {
                ForEach(filteredPatients(), id: \.Patient_ID) { patient in
                    Text("\(patient.First_Name) \(patient.Last_Name)")
                }
            }
        }
        .onAppear {
            loadCSVData()
        }
    }
    
    // Load CSV Data
    func loadCSVData() {
        if let path = Bundle.main.path(forResource: "patients", ofType: "csv") {
            do {
                let csv = try CSV(url: URL(fileURLWithPath: path))
                for row in csv.namedRows {
                    let patient = Patient(
                        Patient_ID: row["Patient_ID"] ?? "",
                        First_Name: row["First_Name"] ?? "",
                        Last_Name: row["Last_Name"] ?? "",
                        Age: row["Age"] ?? "",
                        Gender: row["Gender"] ?? "",
                        Blood_Type: row["Blood_Type"] ?? "",
                        Visit_Reason: row["Visit_Reason"] ?? "",
                        Visit_Date: row["Visit_Date"] ?? "",
                        Diagnosis: row["Diagnosis"] ?? "",
                        Treatment_Plan: row["Treatment_Plan"] ?? "",
                        Room_Assigned: row["Room_Assigned"] ?? "",
                        Doctor_Assigned: row["Doctor_Assigned"] ?? "",
                        Nurse_Assigned: row["Nurse_Assigned"] ?? "",
                        Discharge_Status: row["Discharge_Status"] ?? "",
                        Follow_Up_Required: row["Follow_Up_Required"] ?? ""
                    )
                    patients.append(patient)
                }
            } catch {
                print("Error reading CSV: \(error)")
            }
        }
    }

    // Filtered patients based on searchText
    func filteredPatients() -> [Patient] {
        if searchText.isEmpty {
            return patients
        } else {
            return patients.filter { $0.First_Name.contains(searchText) || $0.Last_Name.contains(searchText) }
        }
    }
}

struct Patient: Identifiable {
    var id = UUID()
    var Patient_ID: String
    var First_Name: String
    var Last_Name: String
    var Age: String
    var Gender: String
    var Blood_Type: String
    var Visit_Reason: String
    var Visit_Date: String
    var Diagnosis: String
    var Treatment_Plan: String
    var Room_Assigned: String
    var Doctor_Assigned: String
    var Nurse_Assigned: String
    var Discharge_Status: String
    var Follow_Up_Required: String
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
