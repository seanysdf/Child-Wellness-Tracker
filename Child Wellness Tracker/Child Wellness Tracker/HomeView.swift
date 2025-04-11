import SwiftUI

struct HomeView: View {
    @State private var selectedChild = 0
    @State private var selectedTab: Tab = .home
    
    let children = [
        Child(name: "Emma", age: "5y", initial: "E", color: .blue),
        Child(name: "Liam", age: "3y", initial: "L", color: .gray),
        Child(name: "Sophia", age: "7y", initial: "S", color: .gray)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Home Emma")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .background(Color.white)
            
            ScrollView {
                VStack(spacing: 16) {
                    // Home title and children selector
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Home")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        HStack {
                            Button(action: {
                                // Previous child
                                if selectedChild > 0 {
                                    selectedChild -= 1
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.gray)
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(0..<children.count, id: \.self) { index in
                                        ChildButton(
                                            child: children[index],
                                            isSelected: selectedChild == index
                                        )
                                        .onTapGesture {
                                            selectedChild = index
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            Button(action: {
                                // Next child
                                if selectedChild < children.count - 1 {
                                    selectedChild += 1
                                }
                            }) {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            
                            Button(action: {
                                // Add child
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.blue)
                            }
                            .padding(.leading, 8)
                            
                            Text("Add Child")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical)
                    .background(Color.white)
                    
                    // Overview Cards
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Overview")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            OverviewCard(
                                icon: "calendar",
                                title: "Next Checkup",
                                value: "3 days",
                                color: .blue
                            )
                            
                            OverviewCard(
                                icon: "pills",
                                title: "Medications",
                                value: "2 due today",
                                color: .orange
                            )
                            
                            OverviewCard(
                                icon: "bell",
                                title: "Updates",
                                value: "3 new",
                                color: .red
                            )
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    .background(Color.white)
                    
                    // Weekly Calendar
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("This Week")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button("View Calendar") {
                                // Action to view full calendar
                            }
                            .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 0) {
                            ForEach(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                                WeekDayView(
                                    day: day,
                                    number: dayNumber(for: day),
                                    isSelected: day == "Tue",
                                    events: eventsForDay(day)
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    .background(Color.white)
                    
                    // Today's Schedule
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("Today's Schedule")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                // Add new schedule item
                            }) {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                            }
                        }
                        .padding(.horizontal)
                        
                        Text("Missed")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        // Missed event
                        ScheduleItemView(
                            time: "2:00 PM",
                            title: "MMR Vaccine Overdue",
                            isAlert: true,
                            color: .red
                        )
                        .padding(.horizontal)
                        
                        Text("Upcoming")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        // Upcoming event
                        ScheduleItemView(
                            time: "8:00 AM",
                            title: "Amoxicillin 250mg",
                            isAlert: false,
                            color: .orange,
                            icon: "pills"
                        )
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    .background(Color.white)
                }
                .padding(.bottom, 80) // Add padding to account for tab bar
            }
            
            // Tab bar at bottom
            CustomTabBar(selectedTab: $selectedTab)
                .background(Color.white)
        }
        .background(Color(UIColor.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // Helper functions for WeekDayView
    func dayNumber(for day: String) -> String {
        switch day {
        case "Mon": return "10"
        case "Tue": return "11"
        case "Wed": return "12"
        case "Thu": return "13"
        case "Fri": return "14"
        case "Sat": return "15"
        default: return ""
        }
    }
    
    func eventsForDay(_ day: String) -> [EventDot] {
        switch day {
        case "Mon": return [EventDot.red, EventDot.orange]
        case "Tue": return [EventDot.orange, EventDot.blue, EventDot.orange]
        case "Wed": return [EventDot.blue, EventDot.orange, EventDot.blue]
        case "Thu": return [EventDot.orange]
        case "Fri": return [EventDot.red]
        case "Sat": return []
        default: return []
        }
    }
}
