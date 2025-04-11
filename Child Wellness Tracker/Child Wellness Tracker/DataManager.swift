import SwiftUI
import Combine

class DataManager: ObservableObject {
    @Published var children: [Child] = []
    @Published var selectedChildIndex: Int = 0
    
    init() {
        // Add sample data
        loadSampleData()
    }
    
    var selectedChild: Child? {
        guard children.indices.contains(selectedChildIndex) else { return nil }
        return children[selectedChildIndex]
    }
    
    func loadSampleData() {
        // Create sample medications
        let medication1 = Medication(
            name: "Amoxicillin",
            dosage: "250mg",
            schedule: [Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!],
            instructions: "Take with food"
        )
        
        // Create sample appointments
        let appointment1 = Appointment(
            title: "Pediatrician Checkup",
            date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
            location: "Dr. Smith's Office",
            doctor: "Dr. Smith",
            notes: "Annual wellness visit"
        )
        
        // Create sample vaccinations
        let vaccination1 = Vaccination(
            name: "MMR Vaccine",
            date: Calendar.current.date(byAdding: .day, value: -30, to: Date())!,
            dueDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            isCompleted: false,
            notes: "Second dose"
        )
        
        // Create sample children
        let emma = Child(
            name: "Emma",
            age: "5y",
            initial: "E",
            color: .blue,
            birthDate: Calendar.current.date(byAdding: .year, value: -5, to: Date())!,
            medications: [medication1],
            appointments: [appointment1],
            vaccinations: [vaccination1]
        )
        
        let liam = Child(
            name: "Liam",
            age: "3y",
            initial: "L",
            color: .green,
            birthDate: Calendar.current.date(byAdding: .year, value: -3, to: Date())!
        )
        
        let sophia = Child(
            name: "Sophia",
            age: "7y",
            initial: "S",
            color: .purple,
            birthDate: Calendar.current.date(byAdding: .year, value: -7, to: Date())!
        )
        
        children = [emma, liam, sophia]
    }
    
    func selectNextChild() {
        if selectedChildIndex < children.count - 1 {
            selectedChildIndex += 1
        }
    }
    
    func selectPreviousChild() {
        if selectedChildIndex > 0 {
            selectedChildIndex -= 1
        }
    }
    
    func addChild(_ child: Child) {
        children.append(child)
    }
}
