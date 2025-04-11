import Foundation

struct Appointment: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
    let location: String
    let doctor: String
    let notes: String
}
