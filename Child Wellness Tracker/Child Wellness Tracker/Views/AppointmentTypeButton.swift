import SwiftUI

struct AppointmentTypeButton: View {
    let type: AppointmentType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                ZStack {
                    Circle()
                        .fill(type.iconColor.opacity(0.2))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: type.icon)
                        .foregroundColor(type.iconColor)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(type.rawValue)
                        .font(.headline)
                    
                    Text(type.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(isSelected ? type.iconColor.opacity(0.1) : Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? type.iconColor : Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
