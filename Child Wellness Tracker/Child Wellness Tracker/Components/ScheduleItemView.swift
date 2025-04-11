import SwiftUI

struct ScheduleItemView: View {
    let time: String
    let title: String
    let isAlert: Bool
    let color: Color
    var icon: String? = nil
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(time)
                    .font(.headline)
                Text("Today")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(width: 80, alignment: .leading)
            
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            
            if isAlert {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(color)
                    .padding(.trailing, 4)
            } else if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .padding(.trailing, 4)
            }
            
            Text(title)
                .font(.body)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
