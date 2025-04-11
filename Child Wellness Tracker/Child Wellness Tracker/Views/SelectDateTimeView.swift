import SwiftUI

struct SelectDateTimeView: View {
    @Environment(\.presentationMode) var presentationMode
    let appointmentType: AppointmentType
    let location: Hospital
    @State private var selectedDate = Date()
    @State private var selectedTime: String?
    @State private var currentMonth = Date()
    
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
    
    private let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MMMM d, yyyy"
        return formatter
    }()
    
    private let availableTimes = [
        "9:00 AM", "9:30 AM", "10:00 AM", "11:00 AM",
        "12:00 PM", "12:45 PM", "1:00 PM", "1:45 PM"
    ]
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Spacer()
                
                Text("Select Date & Time")
                    .font(.headline)
                
                Spacer()
                
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.red)
            }
            .padding()
            
            // Progress indicator
            HStack(spacing: 0) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    )
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 2)
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    )
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 2)
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text("3")
                            .foregroundColor(.white)
                    )
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
                        
                        Button(action: {
                            selectedDate = date
                            selectedTime = nil
                        }) {
                            ZStack {
                                Circle()
                                    .fill(isSelected ? Color.blue : Color.clear)
                                    .frame(width: 35, height: 35)
                                
                                Text(dayFormatter.string(from: date))
                                    .foregroundColor(isSelected ? .white : .primary)
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
            
            // Selected date
            Text(fullDateFormatter.string(from: selectedDate))
                .font(.headline)
                .padding(.top)
            
            // Time selection
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(availableTimes, id: \.self) { time in
                        Button(action: {
                            selectedTime = time
                        }) {
                            Text(time)
                                .font(.subheadline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(selectedTime == time ? Color.blue : Color.blue.opacity(0.1))
                                .foregroundColor(selectedTime == time ? .white : .blue)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
            
            // Save button
            Button(action: {
                // Save appointment action
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save Appointment")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedTime != nil ? Color.blue : Color.gray)
                    .cornerRadius(10)
            }
            .padding()
            .disabled(selectedTime == nil)
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
}
