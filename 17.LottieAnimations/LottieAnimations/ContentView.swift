//
//  ContentView.swift
//  LottieAnimations
//
//  Created by Cain Luo on 2024/1/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                LottieView(fileName: "loading")
                    .frame(width: 250,
                           height: 250,
                           alignment: .center)
            }
            .navigationTitle("SwiftUI Lottie")
        }
    }
}

#Preview {
    ContentView()
}
