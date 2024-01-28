//
//  ContentView.swift
//  ScaleMe
//
//  Created by Cain Luo on 2024/1/28.
//

import SwiftUI

struct ContentView: View {
    @State var currentScale: CGFloat = 0
    @State var finalScale: CGFloat = 1

    var body: some View {
        NavigationView {
            VStack {
                Text("Magnify Me!")
                    .bold()
                    .font(.system(size: 32))
                    .padding()
                    .background(Color.pink)
                    .scaleEffect(finalScale + currentScale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { newScale in
                                currentScale = newScale
                            }
                            .onEnded { scale in
                                finalScale = scale
                                currentScale = 0
                            }
                    )
            }
            .navigationTitle("Magnification Gesture")
        }
    }
}

#Preview {
    ContentView()
}
