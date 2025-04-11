import SwiftUI

struct CalendarView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDate = Date()
    @State private var currentMonth = Date()
    @State private var showAddAppointment = false
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    private let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            // Navigation header
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Calendar")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Empty space to balance layout
                Image(systemName: "arrow.left")
                    .foregroundColor(.clear)
            }
            .padding()
            
            // Month selector
            HStack {
                Text(dateFormatter.string(from: currentMonth))
                    .font(.headline)
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: {
                        withAnimation {
                            currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                    
                    Button(action: {
                        withAnimation {
                            currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.horizontal)
            
            // Weekday headers
            HStack {
                ForEach(["S", "M", "T", "W", "T", "F", "S"], id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.top)
            
            // Calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
                ForEach(getDaysInMonth(), id: \.self) { date in
                    if let date = date {
                        let isSelected = calendar.isDate(selectedDate, inSameDayAs: date)
                        let isToday = calendar.isDateInToday(date)
                        
                        Button(action: {
                            selectedDate = date
                        }) {
                            VStack {
                                Circle()
                                    .fill(isSelected ? Color.blue : (isToday ? Color.blue.opacity(0.2) : Color.clear))
                                    .frame(width: 35, height: 35)
                                    .overlay(
                                        Text(dayFormatter.string(from: date))
                                            .foregroundColor(isSelected ? .white : (isToday ? .blue : .primary))
                                    )
                                
                                // Event indicators would go here
                                if hasEvents(for: date) {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 5, height: 5)
                                }
                            }
                        }
                    } else {
                        // Empty cell for padding
                        Text("")
                            .frame(width: 35, height: 35)
                    }
                }
            }
            .padding()
            
            // Selected date display
            let selectedDateString = calendar.isDateInToday(selectedDate) ? "Today" :
                                    weekdayFormatter.string(from: selectedDate) + " " +
                                    dayFormatter.string(from: selectedDate)
            
            Text(selectedDateString)
                .font(.headline)
                .padding(.vertical)
            
            // Appointments list
            ScrollView {
                VStack(spacing: 15) {
                    // Here we would list the appointments for the selected day
                    // We'll add a couple of sample appointments
                    
                    AppointmentListItem(
                        icon: "stethoscope",
                        iconColor: .blue,
                        title: "Annual Checkup",
                        time: "9:00 AM",
                        location: "UW Medical Center"
                    )
                    
                    AppointmentListItem(
                        icon: "tooth",
                        iconColor: .red,
                        title: "Dental Cleaning",
                        time: "1:00 PM",
                        location: "UW Medical Center"
                    )
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            // Schedule Appointment Button
            Button(action: {
                showAddAppointment = true
            }) {
                Text("Schedule Appointment")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showAddAppointment) {
            SelectAppointmentTypeView()
        }
    }
    
    // Helper function to get days in the current month
    private func getDaysInMonth() -> [Date?] {
        let range = calendar.range(of: .day, in: .month, for: currentMonth)!
        let numDays = range.count
        
        let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))!
        let firstWeekday = calendar.component(.weekday, from: firstDay)
        
        var days = [Date?]()
        
        // Add empty cells for days before the first day of the month
        for _ in 1..<firstWeekday {
            days.append(nil)
        }
        
        // Add the days of the month
        for day in 1...numDays {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDay) {
                days.append(date)
            }
        }
        
        return days
    }
    
    // Helper function to check if a date has events (placeholder for now)
    private func hasEvents(for date: Date) -> Bool {
        // For now, let's say every Tuesday has events
        return calendar.component(.weekday, from: date) == 3
    }
}

// Helper component for appointment list items
struct AppointmentListItem: View {
    let icon: String
    let iconColor: Color
    let title: String
    let time: String
    let location: String
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .foregroundColor(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                Text(time)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(location)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
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
