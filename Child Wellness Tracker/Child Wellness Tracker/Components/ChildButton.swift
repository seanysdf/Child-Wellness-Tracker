import SwiftUI

struct ChildButton: View {
    let child: Child
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(isSelected ? child.color : Color.gray.opacity(0.3))
                    .frame(width: 40, height: 40)
                
                Text(child.initial)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            if isSelected {
                VStack(alignment: .leading) {
                    Text(child.name)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Text(child.age)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(isSelected ? Color.gray.opacity(0.15) : Color.clear)
        .cornerRadius(20)
    }
}
