//
//  ContentView.swift
//  Gradients
//
//  Created by Cain Luo on 2023/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(.systemBlue),
                Color(.systemPink),
                Color("myColor")
            ]),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 220, height: 220, alignment: .center)
                    .padding()
                
                Text("Sunny!")
                    .font(.system(size: 24,
                                  weight: .semibold,
                                  design: .default))
                    .foregroundColor(.white)
                    
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
