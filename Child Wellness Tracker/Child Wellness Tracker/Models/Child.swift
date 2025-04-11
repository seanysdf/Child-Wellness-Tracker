import SwiftUI

struct Child: Identifiable {
    let id = UUID()
    let name: String
    let age: String
    let initial: String
    let color: Color
    let birthDate: Date
    var medications: [Medication]
    var appointments: [Appointment]
    var vaccinations: [Vaccination]
    
    // Helper initializer with fewer required parameters
    init(name: String, age: String, initial: String, color: Color,
         birthDate: Date = Date(), medications: [Medication] = [],
         appointments: [Appointment] = [], vaccinations: [Vaccination] = []) {
        self.name = name
        self.age = age
        self.initial = initial
        self.color = color
        self.birthDate = birthDate
        self.medications = medications
        self.appointments = appointments
        self.vaccinations = vaccinations
    }
}
