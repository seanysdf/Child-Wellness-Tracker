import SwiftUI

struct SelectAppointmentTypeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedAppointmentType: AppointmentType?
    @State private var showLocationSelection = false
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Spacer()
                
                Text("Select Appointment Type")
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
                        Text("1")
                            .foregroundColor(.white)
                    )
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 2)
                
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text("2")
                            .foregroundColor(.gray)
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
            
            Text("What type of appointment do you need?")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            // Appointment type options
            ScrollView {
                VStack(spacing: 12) {
                    AppointmentTypeButton(
                        type: .checkup,
                        isSelected: selectedAppointmentType == .checkup,
                        action: { selectedAppointmentType = .checkup }
                    )
                    
                    AppointmentTypeButton(
                        type: .specialist,
                        isSelected: selectedAppointmentType == .specialist,
                        action: { selectedAppointmentType = .specialist }
                    )
                    
                    AppointmentTypeButton(
                        type: .dental,
                        isSelected: selectedAppointmentType == .dental,
                        action: { selectedAppointmentType = .dental }
                    )
                    
                    AppointmentTypeButton(
                        type: .vaccination,
                        isSelected: selectedAppointmentType == .vaccination,
                        action: { selectedAppointmentType = .vaccination }
                    )
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            // Next button
            Button(action: {
                // Show location selection if an appointment type is selected
                if selectedAppointmentType != nil {
                    showLocationSelection = true
                }
            }) {
                Text("Next")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedAppointmentType != nil ? Color.blue : Color.gray)
                    .cornerRadius(10)
            }
            .padding()
            .disabled(selectedAppointmentType == nil)
        }
        .sheet(isPresented: $showLocationSelection) {
            if let appointmentType = selectedAppointmentType {
                SelectLocationView(appointmentType: appointmentType)
            }
        }
    }
}

// Appointment types
enum AppointmentType: String, CaseIterable {
    case checkup = "Checkup"
    case specialist = "Specialist"
    case dental = "Dental"
    case vaccination = "Vaccination"
    
    var description: String {
        switch self {
        case .checkup:
            return "Regular health checkup with a doctor."
        case .specialist:
            return "See a specialist for a particular issue."
        case .dental:
            return "Meet with a dentist or orthodontist."
        case .vaccination:
            return "Get vaccinated."
        }
    }
    
    var icon: String {
        switch self {
        case .checkup:
            return "stethoscope"
        case .specialist:
            return "person.fill"
        case .dental:
            return "tooth"
        case .vaccination:
            return "syringe"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .checkup:
            return .blue
        case .specialist:
            return .purple
        case .dental:
            return .red
        case .vaccination:
            return .green
        }
    }
}
