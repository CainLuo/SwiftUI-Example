//
//  ContentView.swift
//  TabBar
//
//  Created by Cain Luo on 2024/1/14.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.red
            }
            .navigationTitle("Home")
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
            }
            .navigationTitle("Settings")
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    ContentView()
}
