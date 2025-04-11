import Foundation

struct Vaccination: Identifiable {
    let id = UUID()
    let name: String
    let date: Date
    let dueDate: Date
    let isCompleted: Bool
    let notes: String
}
