//
//  ContentView.swift
//  SwiftUI-Fixed-iOS18-ScroViewGesture-issue
//
//  Created by Cain on 2024/11/27.
//

import SwiftUI

struct ContentView: View {
    @State private var isScrollDisabled: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Volume")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    Text(isScrollDisabled ? "Scroll-Disabled" : "Enabled")
                    
                    VolumeSlider(isScrollDisabled: $isScrollDisabled)
                }
                .padding()
            }
            .scrollDisabled(isScrollDisabled)
            .navigationTitle("Gesture - iOS 18")
        }
    }
}

#Preview {
    ContentView()
}
