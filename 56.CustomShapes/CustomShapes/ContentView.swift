//
//  ContentView.swift
//  CustomShapes
//
//  Created by Cain Luo on 2024/1/30.
//

import SwiftUI

struct ContentView: View {
    @State var scale: CGFloat = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.scale = 1.1
                }, label: {
                    Triangle()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.blue)
                        .scaleEffect(scale)
                })
                
                Button(action: {
                    self.scale = 1.1
                }, label: {
                    SemiCircle()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.blue)
                        .scaleEffect(scale)
                })
            }
            .navigationTitle("Custom Shapes")
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Lines of path
        
        // Start at top middle
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        
        // Move to bottom left
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        // Move to bottom right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        // End at top middle
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct SemiCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX,
                            y: rect.midY),
            radius: rect.size.width / 2,
            startAngle: .degrees(0),
            endAngle: .degrees(180),
            clockwise: false
        )

        return path
    }
}

#Preview {
    ContentView()
}
