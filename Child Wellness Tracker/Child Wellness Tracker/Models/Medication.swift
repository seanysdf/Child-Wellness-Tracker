import Foundation

struct Medication: Identifiable {
    let id = UUID()
    let name: String
    let dosage: String
    var schedule: [Date]
    let instructions: String
    var isCompleted: Bool = false
}
