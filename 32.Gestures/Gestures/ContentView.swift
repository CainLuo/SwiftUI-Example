//
//  ContentView.swift
//  Gestures
//
//  Created by Cain Luo on 2024/1/22.
//

import SwiftUI

struct ContentView: View {
    @GestureState var isLongPressed = false
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        let longPressGesture = LongPressGesture()
            .updating($isLongPressed) { newValue, state, transaction in
                state = newValue
            }
        
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                offset = .zero
            }
        
        VStack {
            Circle()
                .frame(width: 150, height: 150)
                .foregroundColor(isLongPressed ? .orange : .blue)
                .scaleEffect(isLongPressed ? 2 : 1)
                .gesture(longPressGesture)
                .animation(.spring())
            
            Circle()
                .frame(width: 150, height: 150)
                .foregroundColor(.orange)
                .offset(x: offset.width, y: offset.height)
                .gesture(dragGesture)
                .animation(.default)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
