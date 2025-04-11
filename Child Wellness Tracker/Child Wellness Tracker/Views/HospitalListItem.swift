import SwiftUI

struct HospitalListItem: View {
    let hospital: Hospital
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(hospital.name)
                        .font(.headline)
                    
                    Text("\(hospital.address)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("\(hospital.city), \(hospital.state) \(hospital.zipCode)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack {
                    if hospital.isFavorite {
                        Button(action: {
                            // Toggle favorite action would go here
                        }) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.gray)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Text("\(String(format: "%.1f", hospital.distance)) mi")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.1) : Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.blue : Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
