//
//  PinterestApp.swift
//  Pinterest
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI

@main
struct PinterestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // hiding Title Bar...
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
