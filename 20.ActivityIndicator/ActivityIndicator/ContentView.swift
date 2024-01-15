//
//  ContentView.swift
//  ActivityIndicator
//
//  Created by Cain Luo on 2024/1/15.
//

import SwiftUI
import ActivityIndicatorView

struct ContentView: View {
    
    @State var loading = false
    
    var body: some View {
        NavigationView {
            VStack {
                ActivityIndicatorView(isVisible: $loading,
                                      type: .rotatingDots(count: 5))
                .foregroundColor(.red)
                .frame(width: 100,
                       height: 100,
                       alignment: .center)
                .padding()
                
                ActivityIndicatorView(isVisible: $loading,
                                      type: .default(count: 8))
                .foregroundColor(.green)
                .frame(width: 100,
                       height: 100,
                       alignment: .center)
                .padding()

                ActivityIndicatorView(isVisible: $loading,
                                      type: .equalizer(count: 5))
                .foregroundColor(.blue)
                .frame(width: 100,
                       height: 100,
                       alignment: .center)
                .padding()
                
                Button(action: {
                    self.loading.toggle()
                }, label: {
                    Text("Load Data")
                        .bold()
                        .frame(width: 220, height: 50, alignment: .center)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
}
