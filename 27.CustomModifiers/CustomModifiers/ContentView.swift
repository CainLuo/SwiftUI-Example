//
//  ContentView.swift
//  CustomModifiers
//
//  Created by Cain Luo on 2024/1/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "house")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .iconStyle()
                
                Text("Custom Modifiers are cool!")
                    .labelStyle()
            }
            .navigationTitle("Custom Modifiers")
        }
    }
}

extension View {
    func iconStyle() -> some View {
        modifier(IconStyle())
    }
    
    func labelStyle() -> some View {
        modifier(LabelStyle())
    }
}

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24, weight: .bold, design: .default))
            .multilineTextAlignment(.center)
            .foregroundColor(Color(.systemBlue))
    }
}

struct IconStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(.systemPink))
            .frame(width: 100, height: 100)
    }
}

#Preview {
    ContentView()
}
