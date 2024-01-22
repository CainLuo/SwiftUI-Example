//
//  ContentView.swift
//  ScrollView
//
//  Created by Cain Luo on 2024/1/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollViewReader { scrollView in
                ScrollView {
                    Button(action: {
                        withAnimation {
                            scrollView.scrollTo(999, anchor: .center)
                        }
                    }, label: {
                        Text("Scroll To Bottom")
                    })
                    
                    ForEach(0...1000, id: \.self) { num in
                        HStack {
                            Label(
                                title: { Text("Position: \(num)") },
                                icon: { Image(systemName: "house") }
                            )
                            Spacer()
                        }
                        .id(num)
                        .padding()
                    }
                }
            }
            .navigationTitle("Scroll View")
        }
    }
}

#Preview {
    ContentView()
}
