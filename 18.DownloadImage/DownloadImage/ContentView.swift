//
//  ContentView.swift
//  DownloadImage
//
//  Created by Cain Luo on 2024/1/14.
//

import SwURL
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                SwURLImage(url: URL(string: "https://iosacademy.io/assets/images/brand/icon.jpg")!,
                           placeholderImage: Image(systemName: "photo"),
                           transition: .custom(transition: .opacity, animation: .easeInOut(duration: 0.25)))
                .imageProcessing({ image in
                    return image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                })
                .progress({ progress in
                    return Text("Loading: \(progress)")
                })
                .cache(.persistent)
                
                Text("Loading Images")
            }
            .background(Color.secondary)
            .navigationTitle("Welcome")
        }
    }
}

#Preview {
    ContentView()
}
