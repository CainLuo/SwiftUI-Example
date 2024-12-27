//
//  Task.swift
//  SwiftUI-TaskManagement-MVVM
//
//  Created by Cain on 2024/12/9.
//

import SwiftUI

// MARK: Task Model
struct Task: Identifiable {
    var id: UUID = .init()
    var dateAdded: Date
    var taskName: String
    var taskDescription: String
    var taskCategory: Category
}

/// - Sample Tasks
var sampleTasks: [Task] = [
    .init(dateAdded: Date(timeIntervalSince1970: timeInterval1), taskName: "Edit YT Video", taskDescription: "", taskCategory: .general),
    .init(dateAdded: Date(timeIntervalSince1970: timeInterval2), taskName: "Matched Geometry Effect(Issue)", taskDescription: "", taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: timeInterval3), taskName: "Multi-ScrollView", taskDescription: "Multi-ScrollView Multi-ScrollView Multi-ScrollView", taskCategory: .challenge),
    .init(dateAdded: Date(timeIntervalSince1970: timeInterval4), taskName: "Loreal Ipsum", taskDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", taskCategory: .idea),
    .init(dateAdded: Date(timeIntervalSince1970: timeInterval5), taskName: "Complete UI Animation Challenge", taskDescription: "", taskCategory: .challenge),
    .init(dateAdded: Date(timeIntervalSince1970: timeInterval6), taskName: "Fix Shadow issue on Mockup's", taskDescription: "", taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: timeInterval7), taskName: "Add Shadow Effect in Mockview App", taskDescription: "", taskCategory: .idea),
    .init(dateAdded: Date(timeIntervalSince1970: timeInterval8), taskName: "Twitter/Instagram Post", taskDescription: "", taskCategory: .general),
    .init(dateAdded: Date(timeIntervalSince1970: timeInterval9), taskName: "Lorem Ipsum", taskDescription: "", taskCategory: .modifiers)
]

var timeInterval1: TimeInterval = Date().timeIntervalSince1970 - 86400
var timeInterval2: TimeInterval = Date().timeIntervalSince1970 + 86400
var timeInterval3: TimeInterval = Date().timeIntervalSince1970 - 86400 * 2 - 10000
var timeInterval4: TimeInterval = Date().timeIntervalSince1970 - 86400 * 3 - 5000
var timeInterval5: TimeInterval = Date().timeIntervalSince1970 - 86400 * 4 - 3000
var timeInterval6: TimeInterval = Date().timeIntervalSince1970 + 2000
var timeInterval7: TimeInterval = Date().timeIntervalSince1970 + 7000
var timeInterval8: TimeInterval = Date().timeIntervalSince1970 + 3000
var timeInterval9: TimeInterval = Date().timeIntervalSince1970 + 20000

#Preview {
    ContentView()
}
