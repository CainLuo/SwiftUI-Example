//
//  ContentView.swift
//  MVVMPattern
//
//  Created by Cain Luo on 2024/1/13.
//

import SwiftUI

struct ToDoListItem: Identifiable {
    var id = UUID()
    var action: String
}

class ToDoList: ObservableObject {
    @Published var items: [ToDoListItem] = []
}

struct ContentView: View {
    @ObservedObject var viewModel: ToDoList = ToDoList()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.items) { item in
                    Text(item.action)
                }
            }
            .navigationTitle("To Do List")
            .toolbar(content: {
                Button(action: {
                    self.viewModel.items = [
                        ToDoListItem(action: "Go Runing"),
                        ToDoListItem(action: "Get Milk"),
                        ToDoListItem(action: "Do Work"),
                        ToDoListItem(action: "Upload Video"),
                        ToDoListItem(action: "Tech SwiftUI")
                    ]
                }, label: {
                    Text("Refresh")
                })
            })
        }
    }
}

#Preview {
    ContentView()
}
