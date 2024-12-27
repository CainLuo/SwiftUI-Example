//
//  Home.swift
//  SwiftUI-AppleMusicBottomSheet
//
//  Created by Cain on 2024/10/29.
//

import SwiftUI

struct Home: View {
    @State private var showMiniPlayer: Bool = false
    
    var body: some View {
        /// Dummy Tab View
        TabView {
            Text("Home")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Text("Search")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            Text("Notifications")
                .tabItem {
                    Label("Notifications", systemImage: "bell")
                }
            
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .unversalOverlay(show: $showMiniPlayer) {
            /// And that's it. Now that we created an app-wide overlay for our expandable music player, let's get started with its implementation.
//            Text("Hello From Mini Player")
            ExpandableMusicPlayer(show: $showMiniPlayer)
        }
        .onAppear {
            showMiniPlayer = true
        }
    }
}

#Preview {
    RootView {
        Home()
    }
}
