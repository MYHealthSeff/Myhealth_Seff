import SwiftUI

@main
struct Main_App: App {
    var body: some Scene {
        WindowGroup {
            content_view()
        }
    }
}

struct content_view: View {

    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            ZStack {

                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.45, green: 0.55, blue: 0.55),
                        Color(red: 0.38, green: 0.82, blue: 0.64).opacity(0)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        Image("MyHealth.AI Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()

                        Spacer()

                        NavigationLink(destination: Messages_view()) {
                            Image(systemName: "bell.fill") // Message notification icon
                                .resizable()
                                .scaledToFit()
                                .frame(width: 33, height: 33)
                                .padding()
                        }
                    }

                    HStack {
                        Search_bar(text: $searchText)
                            .padding()
                    }
                    .padding(.top, -50)

                    LazyVGrid(columns: columns, spacing: 30) {
                        NavigationLink(destination: MySection_View()) {
                            Iconwith_text(iconName: "house.fill", labelText: "MySection & Rooms")
                        }
                        NavigationLink(destination: Messages_view()) {
                            Iconwith_text(iconName: "message.fill", labelText: "Messages")
                        }
                        NavigationLink(destination: Critical_care_view()) {
                            Iconwith_text(iconName: "bell.fill", labelText: "Critical Care Watch")
                        }
                        NavigationLink(destination: Status_view()) {
                            Iconwith_text(iconName: "doc.text.fill", labelText: "Status Updates")
                        }
                        NavigationLink(destination: ToolsDeviceView()) {
                            Iconwith_text(iconName: "wrench.fill", labelText: "Tools & Devices")
                        }
                        NavigationLink(destination: Management_view()) {
                            Iconwith_text(iconName: "calendar.fill", labelText: "Management & Schedules")
                        }
                        NavigationLink(destination: MyTeams_View()) {
                            Iconwith_text(iconName: "person.3.fill", labelText: "My Teams & Residents")
                        }
                        NavigationLink(destination: NewsInfoview()) {
                            Iconwith_text(iconName: "newspaper.fill", labelText: "News & Info")
                        }
                    }
                    .padding()

                    Spacer()

                    // New bottom navigation bar with vector icons
                    HStack(spacing: 40) {
                        NavigationLink(destination: content_view()) {
                            Image(systemName: "house.fill") // Home icon
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }

                        NavigationLink(destination: Patientdetails_view()) {
                            Image(systemName: "magnifyingglass") // Search icon
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }

                        NavigationLink(destination: Dashboard_view()) {
                            Image(systemName: "speedometer") // Dashboard icon (replacing old desktop icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }

                        NavigationLink(destination: Patientdetails_view()) {
                            Image(systemName: "doc.text.fill") // Orders icon
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }

                        NavigationLink(destination: Patientdetails_view()) {
                            Image(systemName: "person.3.fill") // Active Care Patients icon
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding()
        
                    .cornerRadius(12)
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct iconwith_text: View {
    var iconName: String
    var labelText: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            Text(labelText)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(10)
    }
}
