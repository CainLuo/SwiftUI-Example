//
//  ContentView.swift
//  States
//
//  Created by Cain Luo on 2024/1/13.
//

import SwiftUI

struct ContentView: View {
    
    let images: [Image] = [
        Image("img7"),
        Image(systemName: "bookmark"),
        Image(systemName: "ear"),
        Image("img7"),
        Image("img7")
    ]
    
    var body: some View {
        NavigationView {
            List(0..<5) { index in
                NavigationLink(destination: MyImageView(image: images[index], index: index)) {
                    Text("Item \(index + 1)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

struct MyImageView: View {
    let image: Image
    @State var index: Int
    
    var body: some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(CGFloat(index))
                .onTapGesture {
                    if self.index <= 100 {
                        self.index += 10
                    } else {
                        self.index = 1
                    }
                }
        }
        .padding()
    }
}
