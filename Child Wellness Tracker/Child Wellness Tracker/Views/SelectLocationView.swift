import SwiftUI

struct SelectLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    let appointmentType: AppointmentType
    @State private var selectedLocation: Hospital?
    @State private var showDateTimeSelection = false
    @State private var showFavoritesOnly = false
    
    let hospitals = [
        Hospital(
            name: "UW Medical Center",
            address: "1959 NE Pacific St Main Hospital",
            city: "Seattle",
            state: "WA",
            zipCode: "98195",
            distance: 0.8,
            isFavorite: true
        ),
        Hospital(
            name: "Seattle Children's Hospital",
            address: "4800 Sand Point Way NE",
            city: "Seattle",
            state: "WA",
            zipCode: "98105",
            distance: 2.1,
            isFavorite: true
        )
    ]
    
    var filteredHospitals: [Hospital] {
        showFavoritesOnly ? hospitals.filter { $0.isFavorite } : hospitals
    }
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Spacer()
                
                Text("Select Location")
                    .font(.headline)
                
                Spacer()
                
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.red)
            }
            .padding()
            
            // Progress indicator
            HStack(spacing: 0) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    )
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 2)
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text("2")
                            .foregroundColor(.white)
                    )
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 2)
                
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text("3")
                            .foregroundColor(.gray)
                    )
            }
            .padding()
            
            // Filter options
            VStack(alignment: .leading) {
                Toggle("Show Favorites Only", isOn: $showFavoritesOnly)
                    .padding(.horizontal)
                
                Text("Nearby Hospitals")
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.top)
            }
            
            // Hospital list
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(filteredHospitals) { hospital in
                        HospitalListItem(
                            hospital: hospital,
                            isSelected: selectedLocation?.id == hospital.id,
                            action: {
                                selectedLocation = hospital
                            }
                        )
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            // Next button
            Button(action: {
                if selectedLocation != nil {
                    showDateTimeSelection = true
                }
            }) {
                Text("Next")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedLocation != nil ? Color.blue : Color.gray)
                    .cornerRadius(10)
            }
            .padding()
            .disabled(selectedLocation == nil)
        }
        .sheet(isPresented: $showDateTimeSelection) {
            if let location = selectedLocation {
                SelectDateTimeView(
                    appointmentType: appointmentType,
                    location: location
                )
            }
        }
    }
}

// Hospital model
struct Hospital: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let city: String
    let state: String
    let zipCode: String
    let distance: Double
    var isFavorite: Bool
}
