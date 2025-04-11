import SwiftUI

struct AddTrackingItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedType: TrackingType = .medication
    @State private var time = Date()
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tracking Type")) {
                    Picker("Type", selection: $selectedType) {
                        ForEach(TrackingType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Time")) {
                    DatePicker("Time", selection: $time, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section(header: Text("Details")) {
                    switch selectedType {
                    case .medication:
                        TextField("Medication name", text: $notes)
                        TextField("Dosage", text: .constant(""))
                    case .feeding:
                        TextField("Food or formula", text: $notes)
                        TextField("Amount", text: .constant(""))
                    case .sleep:
                        TextField("Duration", text: $notes)
                    case .measurement:
                        TextField("Value", text: $notes)
                        TextField("Unit", text: .constant(""))
                    case .other:
                        TextField("Description", text: $notes)
                    }
                }
                
                Section {
                    Button("Save") {
                        // Save the tracking item
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("Add to Schedule")
            .navigationBarItems(trailing:
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

enum TrackingType: String, CaseIterable {
    case medication = "Medication"
    case feeding = "Feeding"
    case sleep = "Sleep"
    case measurement = "Measurement"
    case other = "Other"
}
