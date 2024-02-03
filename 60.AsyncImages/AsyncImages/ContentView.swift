//
//  ContentView.swift
//  AsyncImages
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                AsyncImage(url: URL(string: "https://afraz.me/assets/images/courses/teaching.png")!) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.red)
                }
            }
            .navigationTitle("Async Image")
        }
    }
}

#Preview {
    ContentView()
}
