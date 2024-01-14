//
//  ContentView.swift
//  ToDoList
//
//  Created by Cain Luo on 2023/12/17.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(fetchRequest: ToDoListItem.getAllToDoListItems()) var items: FetchedResults<ToDoListItem>
    
    @State var text: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("New Item")) {
                    HStack {
                        TextField("Enter new item...", text: $text)
                            .frame(height: 50)
                        
                        Button(action: {
                            
                            if !text.isEmpty {
                                let newItem = ToDoListItem(context: context)
                                newItem.name = text
                                newItem.createdAt = Date()
                                
                                do {
                                    try context.save()
                                } catch {
                                    print("Save error: \(error)")
                                }
                            }
                        }, label: {
                            Text("Save")
                        })
                    }
                }
                
                Section {
                    ForEach(items) { toDoListItem in
                        VStack(alignment: .leading) {
                            Text("\(toDoListItem.name!)")
                                .font(.headline)
                            Text("\(toDoListItem.createdAt!)")
                        }
                    }.onDelete(perform: { indexSet in
                        guard let index = indexSet.first else {
                            return
                        }
                        let itemToDelete = items[index]
                        context.delete(itemToDelete)
                        do {
                            try context.save()
                        } catch {
                            print("Delete error: \(error)")
                        }
                    })
                }
            }
            .listStyle(.plain)
            .navigationTitle("To Do List")
        }
    }
}

#Preview {
    ContentView()
}
