//
//  ContentView.swift
//  TapGesture
//
//  Created by Cain Luo on 2024/1/28.
//

import SwiftUI

struct ContentView: View {
    @State var showLike: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(systemName: "globe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                    .background(Color.blue)
                    .onTapGesture(count: 2) {
                        withAnimation {
                            showLike.toggle()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                showLike.toggle()
                            }
                        }
                    }
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .opacity(showLike ? 1 : 0)
                    .animation(.linear(duration: 0.3))
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
