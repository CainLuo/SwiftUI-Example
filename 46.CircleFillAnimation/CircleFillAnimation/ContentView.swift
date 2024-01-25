//
//  ContentView.swift
//  CircleFillAnimation
//
//  Created by Cain Luo on 2024/1/25.
//

import SwiftUI

struct ContentView: View {
    @State var fill: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 11/255.0,
                          green: 15/255.0,
                          blue: 128/255.0,
                          alpha: 1))
            
            ZStack {
                // Tack circle
                Circle()
                    .stroke(Color.white.opacity(0.3),
                            style: StrokeStyle(lineWidth: 30))
                
                // Animation circle
                ZStack {
                    Text(String(format: "%.f", fill * 100) + "%")
                        .font(.system(size: 52))
                        .foregroundColor(.white)
                    Circle()
                        .trim(from: 0, to: fill)
                        .stroke(Color.yellow,
                                style: StrokeStyle(lineWidth: 30))
                        .rotationEffect(.init(degrees: -90))
                        .animation(.linear(duration: 0.5))
                }
            }
            .padding(50)
        }
        .onTapGesture {
            for x in 0...100 {
                DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(x/15)) {
                    guard self.fill < 1 else {
                        return
                    }
                    self.fill += 0.01
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
