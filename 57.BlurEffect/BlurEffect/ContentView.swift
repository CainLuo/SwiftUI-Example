//
//  ContentView.swift
//  BlurEffect
//
//  Created by Cain Luo on 2024/1/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let frame = proxy.frame(in: .global)
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: frame.size.width,
                           height: frame.size.height)
            }
            
            GeometryReader { proxy in
                BlurView(style: .systemThinMaterialDark)
            }
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct BlurView: UIViewRepresentable {
    typealias UIViewType = UIVisualEffectView
    
    let style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

#Preview {
    ContentView()
}
