import SwiftUI

struct PatientListView: View {
    @State private var searchText = ""
    let patients: [Patient] = PatientDataLoader.loadCSV()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredPatients) { patient in
                    VStack(alignment: .leading) {
                        Text(patient.name)
                            .font(.headline)
                        Text("Age: \(patient.age)")
                            .font(.subheadline)
                        Text("Condition: \(patient.condition)")
                            .font(.subheadline)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Patients")
        }
    }
    
    private var filteredPatients: [Patient] {
        if searchText.isEmpty {
            return patients
        } else {
            return patients.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct PatientListView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListView()
    }
}
