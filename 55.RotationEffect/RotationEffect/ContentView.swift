//
//  ContentView.swift
//  RotationEffect
//
//  Created by Cain Luo on 2024/1/28.
//

import SwiftUI

struct ContentView: View {
    @State var currentAngle: Angle = .degrees(0)
    @State var finalAngle: Angle = .degrees(0)

    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, world!")
                    .bold()
                    .font(.system(size: 32))
                    .padding()
                    .rotationEffect(currentAngle + finalAngle)
                    .gesture (
                        RotationGesture()
                            .onChanged { angle in
                                currentAngle = angle
                            }
                            .onEnded { angle in
                                finalAngle = angle
                                currentAngle = .degrees(.zero)
                            }
                    )
            }
            .navigationTitle("Rotation Effect")
        }
    }
}

#Preview {
    ContentView()
}
