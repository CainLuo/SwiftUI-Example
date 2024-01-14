//
//  ContentView.swift
//  ColorPicker
//
//  Created by Cain Luo on 2023/12/17.
//

import SwiftUI

struct ContentView: View {
    @State var backgroundColor = Color(.systemBackground)
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                
                ColorPicker("Select Color",
                            selection: $backgroundColor)
                    .padding()
            }
            .navigationTitle("Color Picker")
        }
    }
}

#Preview {
    ContentView()
}
