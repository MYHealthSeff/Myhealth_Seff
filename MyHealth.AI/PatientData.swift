import Foundation

struct Patient: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let condition: String
    
    init(name: String, age: Int, condition: String) {
        self.name = name
        self.age = age
        self.condition = condition
    }
}

class PatientDataLoader {
    static func loadCSV() -> [Patient] {
        var patients: [Patient] = []
        
        guard let filePath = Bundle.main.path(forResource: "database", ofType: "csv") else {
            print("CSV file not found")
            return patients
        }
        
        do {
            let content = try String(contentsOfFile: filePath)
            let rows = content.components(separatedBy: "\n")
            
            for row in rows {
                let columns = row.components(separatedBy: ",")
                if columns.count == 3 {
                    if let age = Int(columns[1]) {
                        let patient = Patient(name: columns[0], age: age, condition: columns[2])
                        patients.append(patient)
                    }
                }
            }
        } catch {
            print("Error reading CSV file: \(error)")
        }
        
        return patients
    }
}
