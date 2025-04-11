import SwiftUI

struct WeekDayView: View {
    let day: String
    let number: String
    let isSelected: Bool
    let events: [EventDot]
    
    var body: some View {
        VStack(spacing: 8) {
            Text(day)
                .font(.caption)
                .foregroundColor(.gray)
            
            ZStack {
                Circle()
                    .fill(isSelected ? Color.blue : Color.clear)
                    .frame(width: 36, height: 36)
                
                Text(number)
                    .font(.headline)
                    .foregroundColor(isSelected ? .white : .black)
            }
            
            HStack(spacing: 2) {
                ForEach(events) { event in
                    Circle()
                        .fill(event.color)
                        .frame(width: 6, height: 6)
                }
            }
            .frame(height: 10)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(isSelected ? Color.blue.opacity(0.1) : Color.clear)
        .cornerRadius(10)
    }
}
