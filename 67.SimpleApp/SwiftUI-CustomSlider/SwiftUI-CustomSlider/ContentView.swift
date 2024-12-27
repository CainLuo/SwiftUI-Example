//
//  ContentView.swift
//  SwiftUI-CustomSlider
//
//  Created by Cain on 2024/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var volume: CGFloat = 30
    var body: some View {
        NavigationStack {
            VStack {
                CustomSlider(value: $volume, in: 0...100) {
                    /// 6.This is a simple view that consists of a textual representation of the progress value and a variable value as the SFSymbol.
                    HStack {
                        Image(
                            systemName: "speaker.wave.3.fill",
                            variableValue: volume / 100
                        )
                        
                        Spacer(minLength: 0)
                        
                        Text(String(format: "%.1f", volume) + "%")
                            .font(.callout)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(15)
            .navigationTitle("Expandable Slider")
        }
    }
}

#Preview {
    ContentView()
}
