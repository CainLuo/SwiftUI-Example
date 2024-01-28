//
//  ContentView.swift
//  ToolBar
//
//  Created by Cain Luo on 2024/1/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                Text("Hello, world!")
            }
            .navigationTitle("ToolBar")
            .toolbar(content: {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "bell")
                    })
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        
                    }, label: {
                        Text("Search")
                    })
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        print("go to my account")
                    }, label: {
                        Text("My Account")
                    })
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
