//
//  ContentView.swift
//  AccessibilityTutorial
//
//  Created by Cain Luo on 2024/1/25.
//

import SwiftUI

struct ContentView: View {
    @State var selectedNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("1")
                        .padding()
                    Text("2")
                        .padding()
                    Text("3")
                        .padding()
                    Text("4")
                        .padding()
                }
                .accessibilityElement()
                .accessibilityLabel(Text("Numbers Row"))
                .accessibilityValue(Text("\(self.selectedNumber)"))
                .accessibilityAdjustableAction { direction in
                    switch direction {
                    case .increment:
                        self.selectedNumber += 1
                    case .decrement:
                        guard self.selectedNumber > 1 else {
                            return
                        }
                        self.selectedNumber -= 1
                    @unknown default:
                        break
                    }
                }
            }
            .navigationTitle("Accessibility Tutorial")
        }
    }
}

#Preview {
    ContentView()
}
