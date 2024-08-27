import SwiftUI

struct Dashboard_view: View {
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        VStack {
            Text("Dashboard")
                .font(.largeTitle)
                .padding()
            
            LazyVGrid(columns: columns, spacing: 20) {
                NavigationLink(destination: Text("Detail for Total Active Patients")) {
                    Iconwith_text(iconName: "person.fill", labelText: "Total Active Patients\n\(Int.random(in: 50...100))")
                }
                NavigationLink(destination: Text("Detail for Avg. Wait Time")) {
                    Iconwith_text(iconName: "clock.fill", labelText: "Avg. Wait Time\n15 mins")
                }
                NavigationLink(destination: Text("Detail for Bed Occupancy")) {
                    Iconwith_text(iconName: "bed.double.fill", labelText: "Bed Occupancy\n\(Int.random(in: 50...100))%")
                }
                NavigationLink(destination: Text("Detail for Available Staff")) {
                    Iconwith_text(iconName: "person.3.fill", labelText: "Available Staff\n\(Int.random(in: 10...20))")
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Dashboard")
    }
}

