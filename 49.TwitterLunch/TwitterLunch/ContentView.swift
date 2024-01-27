//
//  ContentView.swift
//  TwitterLunch
//
//  Created by Cain Luo on 2024/1/27.
//

import SwiftUI

struct ContentView: View {
    let color: UIColor = UIColor(
        red: 29/255.0,
        green: 161/255.0,
        blue: 242/255.0,
        alpha: 1
    )
    
    @State var animate: Bool = false
    @State var showSplash: Bool = true

    var body: some View {
        VStack {
            // Content
            ZStack {
                ZStack {
                    VStack {
                        Image(systemName: "house")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                        Text("Home")
                            .font(.system(size: 42))
                        
                        Button(action: {
                            print("Go Home")
                        }, label: {
                            Text("Go Home")
                                .frame(width: 200, height: 50)
                                .background(Color(color))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        })
                    }
                }
                
                
                ZStack {
                    Color(color)
                    
                    Image(systemName: "house")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .scaleEffect(animate ? 50 : 1)
                        .animation(.easeOut(duration: 0.4))
                }
                .edgesIgnoringSafeArea(.all)
                .animation(.linear(duration: 0.5))
                .opacity(showSplash ? 1 : 0)
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                animate.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showSplash.toggle()
            }
        }
    }
}

#Preview {
    ContentView()
}
