import SwiftUI

// Child model
struct Child: Identifiable {
    let id = UUID()
    let name: String
    let age: String
    let initial: String
    let color: Color
}

// Tab enum
enum Tab {
    case home, records, medicine, forums
}

// Event models
struct EventDot: Identifiable {
    let id = UUID()
    let color: Color
    
    static let red = EventDot(color: .red)
    static let blue = EventDot(color: .blue)
    static let orange = EventDot(color: .orange)
}
