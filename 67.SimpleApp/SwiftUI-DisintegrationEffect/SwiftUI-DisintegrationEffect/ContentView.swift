//
//  ContentView.swift
//  SwiftUI-DisintegrationEffect
//
//  Created by Cain on 2024/11/22.
//

import SwiftUI

struct ContentView: View {
    @State private var snapEffect: Bool = false
    @State private var isRemoved: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                /// 11.I hope you enjoyed this video. As I mentioned earlier, Here are some additional tips:
                /// 1.Use this effect for elements like buttons, texts, images, or even message bubbles, but not for navigation stacks or scroll views.
                /// 2.Always consider a lower particle count. In extreme cases, you can go up to 1600, but don;t exceed that.
                /// 3.Try to block user interaction when this effect is happening. For example, in Safari, distracting elements will disable when the same effect is happening. Try to follow that pattern.
                /// 4.Don't use fancy modifiers for each particle. Offset, opacity, and rotation are recommended.
                if !isRemoved {
                    Group {
                        Image(.pic)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .disintegrationEffect(isDeleted: snapEffect) {
                                withAnimation(.snappy) {
                                    isRemoved = true
                                }
                            }
                        
                        Button("Remove View") {
                            snapEffect = true
                        }
                    }
                }
            }
            .navigationTitle("Disintegration Effect")
        }
    }
}

#Preview {
    ContentView()
}
