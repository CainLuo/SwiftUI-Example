//
//  ContentView.swift
//  Grids
//
//  Created by Cain Luo on 2023/12/24.
//

import SwiftUI

struct ContentView: View {
    let items = Array(1...1000).map { "Element \($0)" }
    
    let layout = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: layout, content: {
                    ForEach(items, id: \.self) { item in
                        VStack {
                            Image(systemName: "eraser.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .border(Color.secondary)
                                .cornerRadius(12)
                                .padding()
                            
                            Spacer()
                            
                            Button("Get") {
                                // do something
                            }
                            .foregroundColor(.blue)
                            .padding()
                        }
                    }
                })
            }
            .navigationTitle("App Store")
        }
    }
}

#Preview {
    ContentView()
}
