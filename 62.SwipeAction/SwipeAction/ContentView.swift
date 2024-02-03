//
//  ContentView.swift
//  SwipeAction
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI

struct ContentView: View {
    let items = [
        "Get Milk",
        "Go Runing",
        "Edit Video",
        "Do Homework",
        "Get Milk",
        "Go Runing",
        "Edit Video",
        "Do Homework",
        "Get Milk",
        "Go Runing",
        "Edit Video",
        "Do Homework"
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                        
                        Text(item)
                            .bold()
                    }
                    .swipeActions {
                        Button(action: {
                            print("do something")
                        }, label: {
                            Image(systemName: "bell")
                        })
                        .tint(.yellow)
                        
                        Button(action: {
                            print("do something")
                        }, label: {
                            Image(systemName: "trash")
                        })
                        .tint(.red)
                    }
                    .swipeActions(edge: .leading) {
                        Button(action: {
                            print("do something")
                        }, label: {
                            Image(systemName: "gear")
                        })
                        .tint(.purple)
                    }
                }
            }
            .navigationTitle("To Do List")
        }
    }
}

#Preview {
    ContentView()
}
