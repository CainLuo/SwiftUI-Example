//
//  ContentView.swift
//  Shapes
//
//  Created by Cain Luo on 2024/1/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                Button(action: {
                    
                }, label: {
                    Text("Delete Account")
                        .frame(width: 200, height: 50)
                        .foregroundColor(.red)
                        .background(Color.black)
                        .clipShape(Capsule())
                })
                
                Circle()
                    .foregroundColor(Color.blue)
                    .frame(width: 150, height: 150)
                
                Rectangle()
                    .foregroundColor(Color.red)
                    .frame(width: 200, height: 150)
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.green)
                    .frame(width: 200, height: 150)
                
                Capsule()
                    .foregroundColor(Color.purple)
                    .frame(width: 200, height: 50)
                
                Ellipse()
                    .foregroundColor(Color.yellow)
                    .frame(width: 100, height: 50)
            }
            .navigationTitle("Shapes")
        }
    }
}

#Preview {
    ContentView()
}
