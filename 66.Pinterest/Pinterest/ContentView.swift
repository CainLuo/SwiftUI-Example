//
//  ContentView.swift
//  Pinterest
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
        // always light Theme
            .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
