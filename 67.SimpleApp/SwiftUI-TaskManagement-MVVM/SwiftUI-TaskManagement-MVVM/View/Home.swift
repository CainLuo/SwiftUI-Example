//
//  Home.swift
//  SwiftUI-TaskManagement-MVVM
//
//  Created by Cain on 2024/12/9.
//

import SwiftUI

struct Home: View {
    /// - View Properties
    @State private var currentDay = Date()
    @State private var tasks: [Task] = sampleTasks
    @State private var addNewTask: Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            TimeLineView()
                .padding(15)
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            HeaderView()
        }
        .fullScreenCover(isPresented: $addNewTask) {
            AddTaskView { task in
                /// - Simply Add it to tasks
                tasks.append(task)
            }
        }
    }

    /// - Timeline View
    @ViewBuilder
    func TimeLineView() -> some View {
        ScrollViewReader { proxy in
            let hours = Calendar.current.hours
            let midHour = hours[hours.count / 2]
            VStack {
                ForEach(hours, id: \.self) { hour in
                    TimelineViewRow(hour)
                        .id(hour)
                }
            }
            .onAppear {
                /// Because the timeline view begins at 12 a.m., we want it to begin at 12 p.m., which is midday, so we use ScrollViewReader Proxy to set it to midday.
                proxy.scrollTo(midHour)
            }
        }
    }

    /// - Timeline View Row
    @ViewBuilder
    func TimelineViewRow(_ date: Date) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Text(date.toString("h a"))
                .ubuntu(14, .regular)
                .frame(width: 45, alignment: .leading)

            /// - Filtering Tasks
            let calendar = Calendar.current
            /// Filtering tasks based on hour and also verifying whether the date is the same as the selected week day
            let fileterdTasks = tasks.filter {
                /// date is currentDay
                if let hour = calendar.dateComponents([.hour], from: date).hour,
                   let taskHour = calendar.dateComponents([.hour], from: $0.dateAdded).hour,
                   hour == taskHour && calendar.isDate($0.dateAdded, inSameDayAs: currentDay) {
                    return true
                }
                return false
            }
            
            if fileterdTasks.isEmpty {
                Rectangle()
                    .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
                    .frame(height: 0.5)
                    .offset(y: 10)
            } else {
                /// - Task View
                VStack(spacing: 10) {
                    ForEach(fileterdTasks) { task in
                        TaskRow(task)
                    }
                }
            }
        }
        .hAlign(.leading)
        .padding(.vertical, 15)
    }

    /// - Task View
    @ViewBuilder
    func TaskRow(_ task: Task) -> some View {
        VStack(alignment: .leading) {
            Text(task.taskName.uppercased())
                .ubuntu(16, .regular)
                .foregroundStyle(task.taskCategory.color)
            
            if task.taskDescription != "" {
                Text(task.taskDescription)
                    .ubuntu(14, .light)
                    .foregroundStyle(task.taskCategory.color.opacity(0.8))
            }
        }
        .hAlign(.leading)
        .padding(12)
        .background {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(task.taskCategory.color)
                    .frame(width: 4)
                
                Rectangle()
                    .fill(task.taskCategory.color.opacity(0.25))
            }
        }
    }

    /// - Header View
    @ViewBuilder
    func HeaderView() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Today")
                        .ubuntu(30, .light)
                    
                    Text("Welcome iJustine")
                        .ubuntu(14, .light)
                }
                .hAlign(.leading)
                
                Button {
                    addNewTask.toggle()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                        Text("Add Task")
                            .ubuntu(15, .regular)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background {
                        Capsule()
                            .fill(Color("Blue").gradient)
                    }
                    .foregroundStyle(.white)
                }

            }
            
            /// - Today Date in String
            Text(Date().toString("MMM YYYY"))
                .ubuntu(16, .medium)
                .hAlign(.leading)
                .padding(.top, 15)

            /// - Current Week Row
            WeekRow()
        }
        .padding(15)
        .background {
            VStack(spacing: 0) {
                Color.white
                
                /// - Gradient Opacity Background
                Rectangle()
                    .fill(.linearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom))
                    .frame(height: 20)
            }
            .ignoresSafeArea()
        }
    }

    /// - Week Row
    @ViewBuilder
    func WeekRow() -> some View {
        HStack(spacing: 0) {
            ForEach(Calendar.current.currentWeek) { weekDay in
                let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                VStack(spacing: 6) {
                    Text(weekDay.string.prefix(3))
                        .ubuntu(12, .medium)
                    
                    Text(weekDay.date.toString("dd"))
                        .ubuntu(16, status ? .medium : .regular)
                }
                .foregroundStyle(status ? Color("Blue") : .gray)
                .hAlign(.center)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentDay = weekDay.date
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, -15)
    }
}

#Preview {
    ContentView()
}

// MARK: View Extensions
extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }

    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}

// MARK: Date Extension
extension Date {
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

// MARK: Calander Extension
extension Calendar {
    /// - Return 24 Hours in a day
    var hours: [Date] {
        let startOfDay = self.startOfDay(for: Date())
        var hours: [Date] = []
        for index in 0 ..< 24 {
            if let date = self.date(byAdding: .hour, value: index, to: startOfDay) {
                hours.append(date)
            }
        }
        return hours
    }
    
    /// - Return Current Week in Array Format
    var currentWeek: [WeekDay] {
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else { return [] }
        var week: [WeekDay] = []
        for index in 0 ..< 7 {
            if let day = self.date(byAdding: .day, value: index, to: firstWeekDay) {
                let weekDaySymbol: String = day.toString("EEEE")
                let isToday = self.isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day, isToday: isToday))
            }
        }
        return week
    }

    /// - Used to Store Data of Each Week Day
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }
}
