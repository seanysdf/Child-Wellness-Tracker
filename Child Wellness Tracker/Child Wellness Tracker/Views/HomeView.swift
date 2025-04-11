import SwiftUI

struct HomeView: View {
    @State private var selectedChild = 0
    @State private var showCalendarView = false
    @State private var showScheduleAppointment = false
    @State private var showAddChild = false
    @State private var showAddTrackingItem = false
    
    // Sample data
    let children = [
        Child(name: "Emma", age: "5y", initial: "E", color: .blue),
        Child(name: "Liam", age: "3y", initial: "L", color: .gray),
        Child(name: "Sophia", age: "7y", initial: "S", color: .gray)
    ]
    
    // Sample events
    let upcomingEvents = [
        ScheduleEvent(
            id: UUID(),
            time: "2:00 PM",
            title: "MMR Vaccine Overdue",
            day: "Today",
            type: .vaccination,
            isMissed: true
        ),
        ScheduleEvent(
            id: UUID(),
            time: "8:00 AM",
            title: "Amoxicillin 250mg",
            day: "Today",
            type: .medication,
            isMissed: false
        ),
        ScheduleEvent(
            id: UUID(),
            time: "1:30 PM",
            title: "Pediatrician Appointment",
            day: "Tomorrow",
            type: .checkup,
            isMissed: false
        )
    ]
    
    var missedEvents: [ScheduleEvent] {
        return upcomingEvents.filter { $0.isMissed }
    }
    
    var futureEvents: [ScheduleEvent] {
        return upcomingEvents.filter { !$0.isMissed }
    }
    
    var nextAppointmentIn: String {
        // In a real app, you would calculate this from actual appointments
        return "3 days"
    }
    
    var medicationsDueToday: Int {
        // In a real app, you would count actual medications due today
        return 2
    }
    
    var unreadUpdates: Int {
        // In a real app, you would count actual unread updates
        return 3
    }
    
    var selectedChildName: String {
        return children[selectedChild].name
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Home \(selectedChildName)")
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
                            .disabled(selectedChild == 0)
                            .opacity(selectedChild == 0 ? 0.5 : 1)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(0..<children.count, id: \.self) { index in
                                        ChildButton(
                                            child: children[index],
                                            isSelected: selectedChild == index
                                        )
                                        .onTapGesture {
                                            withAnimation {
                                                selectedChild = index
                                            }
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
                            .disabled(selectedChild == children.count - 1)
                            .opacity(selectedChild == children.count - 1 ? 0.5 : 1)
                            
                            Button(action: {
                                showAddChild = true
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
                                value: nextAppointmentIn,
                                color: .blue
                            )
                            .onTapGesture {
                                showCalendarView = true
                            }
                            
                            OverviewCard(
                                icon: "pills",
                                title: "Medications",
                                value: "\(medicationsDueToday) due today",
                                color: .orange
                            )
                            
                            OverviewCard(
                                icon: "bell",
                                title: "Updates",
                                value: "\(unreadUpdates) new",
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
                                showCalendarView = true
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
                                .onTapGesture {
                                    showCalendarView = true
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Schedule Appointment button
                        Button(action: {
                            showScheduleAppointment = true
                        }) {
                            HStack {
                                Image(systemName: "calendar.badge.plus")
                                    .foregroundColor(.white)
                                Text("Schedule Appointment")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                    .padding(.vertical)
                    .background(Color.white)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("Today's Schedule")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                // Show tracking form instead of appointment scheduling
                                showAddTrackingItem = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                            }
                        }
                        .padding(.horizontal)
                        
                        if !missedEvents.isEmpty {
                            Text("Missed")
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                            
                            ForEach(missedEvents) { event in
                                ScheduleItemView(
                                    time: event.time,
                                    title: event.title,
                                    isAlert: true,
                                    color: event.type.color,
                                    icon: event.type.icon
                                )
                                .padding(.horizontal)
                            }
                        }
                        
                        Text("Upcoming")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        if futureEvents.isEmpty {
                            Text("No upcoming events today")
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.bottom)
                        } else {
                            ForEach(futureEvents) { event in
                                ScheduleItemView(
                                    time: event.time,
                                    title: event.title,
                                    isAlert: false,
                                    color: event.type.color,
                                    icon: event.type.icon
                                )
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical)
                    .background(Color.white)
                }
                .padding(.bottom, 80) // Add padding to account for tab bar
            }
        }
        .background(Color(UIColor.systemGray6))
        .edgesIgnoringSafeArea(.bottom)
        .fullScreenCover(isPresented: $showCalendarView) {
            CalendarView()
        }
        .sheet(isPresented: $showScheduleAppointment) {
            SelectAppointmentTypeView()
        }
        
        .sheet(isPresented: $showAddTrackingItem) {
            AddTrackingItemView()
        }
        
        .sheet(isPresented: $showAddChild) {
            // This would be your Add Child view
            Text("Add Child Form")
                .font(.title)
                .padding()
        }
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

// Event type for schedule items
enum EventType: Identifiable {
    case medication
    case checkup
    case vaccination
    case other
    
    var id: String {
        switch self {
        case .medication: return "medication"
        case .checkup: return "checkup"
        case .vaccination: return "vaccination"
        case .other: return "other"
        }
    }
    
    var color: Color {
        switch self {
        case .medication: return .orange
        case .checkup: return .blue
        case .vaccination: return .red
        case .other: return .gray
        }
    }
    
    var icon: String {
        switch self {
        case .medication: return "pills"
        case .checkup: return "stethoscope"
        case .vaccination: return "syringe"
        case .other: return "calendar"
        }
    }
}

// Schedule event model
struct ScheduleEvent: Identifiable {
    let id: UUID
    let time: String
    let title: String
    let day: String
    let type: EventType
    let isMissed: Bool
}
