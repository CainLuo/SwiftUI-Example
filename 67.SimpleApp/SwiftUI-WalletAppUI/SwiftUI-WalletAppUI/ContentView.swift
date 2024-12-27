//
//  ContentView.swift
//  SwiftUI-WalletAppUI
//
//  Created by Cain on 2024/12/6.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            Home(size: size, safeArea: safeArea)
                .ignoresSafeArea(.container, edges: .top)
        }
    }
}

#Preview {
    ContentView()
}
