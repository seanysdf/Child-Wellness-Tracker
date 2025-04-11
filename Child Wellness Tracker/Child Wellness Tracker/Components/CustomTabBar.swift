import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(spacing: 4) {
                Image(systemName: "house.fill")
                    .foregroundColor(selectedTab == .home ? .blue : .gray)
                Text("Home")
                    .font(.caption)
                    .foregroundColor(selectedTab == .home ? .blue : .gray)
            }
            .onTapGesture { selectedTab = .home }
            
            Spacer()
            
            VStack(spacing: 4) {
                Image(systemName: "folder.fill")
                    .foregroundColor(selectedTab == .records ? .blue : .gray)
                Text("Records")
                    .font(.caption)
                    .foregroundColor(selectedTab == .records ? .blue : .gray)
            }
            .onTapGesture { selectedTab = .records }
            
            Spacer()
            
            VStack(spacing: 4) {
                Image(systemName: "pill.fill")
                    .foregroundColor(selectedTab == .medicine ? .blue : .gray)
                Text("Medicine")
                    .font(.caption)
                    .foregroundColor(selectedTab == .medicine ? .blue : .gray)
            }
            .onTapGesture { selectedTab = .medicine }
            
            Spacer()
            
            VStack(spacing: 4) {
                Image(systemName: "person.2.fill")
                    .foregroundColor(selectedTab == .forums ? .blue : .gray)
                Text("Forums")
                    .font(.caption)
                    .foregroundColor(selectedTab == .forums ? .blue : .gray)
            }
            .onTapGesture { selectedTab = .forums }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
    }
}
