import SwiftUI

struct EventDot: Identifiable {
    let id = UUID()
    let color: Color
    
    static let red = EventDot(color: .red)
    static let blue = EventDot(color: .blue)
    static let orange = EventDot(color: .orange)
}
