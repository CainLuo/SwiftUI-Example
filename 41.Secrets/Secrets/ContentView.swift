//
//  ContentView.swift
//  Secrets
//
//  Created by Cain Luo on 2024/1/24.
//

import SwiftUI
import SwiftUIX

struct ContentView: View {
    @State var image: Data?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.ignoresSafeArea()
                
                VStack {
                    LinkPresentationView(url: URL(string: "https://www.apple.com")!)
                        .frame(width: 200, height: 200)
                    
                    ActivityIndicator()
                        .animated(true)
                        .style(.large)
                    
                    BlurEffectView(style: .light) {
                            Text("Hello blur effect")
                        }
                        .frame(width: 200, height: 200)
                }
                .navigationTitle("SwiftUIX")
            }
        }
    }
}

#Preview {
    ContentView()
}
