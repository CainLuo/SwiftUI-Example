//
//  ContentView.swift
//  GeometryReader
//
//  Created by Cain Luo on 2024/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0...20, id: \.self) { num in
                        GeometryReader { proxy in
                            let x = proxy.frame(in: .global).origin.x
                            Text("\(Int(x))")
                                .bold()
                                .font(.system(size: 24))
                        }
                        .background(Color.blue)
                        .frame(width: 100, height: 100)
                        .padding()
                    }
                }
            }
            .background(Color.pink)
        }
    }
}

#Preview {
    ContentView()
}
