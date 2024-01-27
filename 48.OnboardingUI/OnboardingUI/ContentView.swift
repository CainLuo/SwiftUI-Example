//
//  ContentView.swift
//  OnboardingUI
//
//  Created by Cain Luo on 2024/1/26.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, world!")
                    .padding()
            }
            .navigationTitle("Home")
        }
        .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
            OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
        })
    }
}

#Preview {
    ContentView()
}
