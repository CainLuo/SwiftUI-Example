//
//  ContentView.swift
//  Labels
//
//  Created by Cain Luo on 2024/1/22.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID()
    var title: String
    var systemImageName: String
}

struct ContentView: View {
    let items: [MenuItem] = [
        MenuItem(title: "Home", systemImageName: "house"),
        MenuItem(title: "Profile", systemImageName: "person.circle"),
        MenuItem(title: "Activity", systemImageName: "bell"),
        MenuItem(title: "Settings", systemImageName: "gear"),
        MenuItem(title: "Airplane", systemImageName: "airplane"),
        MenuItem(title: "Rate App", systemImageName: "star")
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ForEach(items) { item in
                    Label(
                        title: { Text(item.title) },
                        icon: { Image(systemName: item.systemImageName)
                        }
                    )
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.blue)
                    .padding()
                    .onTapGesture {
                        print("tapped")
                    }
                    
                    Divider()
                }
                Spacer()
            }
            .navigationTitle("Labels")
        }
    }
}

#Preview {
    ContentView()
}
