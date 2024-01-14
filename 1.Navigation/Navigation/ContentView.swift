//
//  ContentView.swift
//  Navigation
//
//  Created by Cain Luo on 2023/12/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Screen(imageName: "house",
                   text: "First Screen",
                   title: "Home",
                   color: .pink)
        }
    }
}

struct Screen: View {
    let imageName: String
    let text: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .padding()
            
            Text(text)
                .font(.system(size: 30, weight: .light, design: .default))
                .padding()
            
            NavigationLink(destination: Screen(imageName: "bell", 
                                               text: "Secound Screen",
                                               title: "Notifications",
                                               color: .green)) {
                ContinueButton(color: color)
            }
        }
        .getNavigationTitle(title: title)
    }
}

struct ContinueButton: View {
    
    let color: Color
    
    var body: some View {
        Text("Continue")
            .frame(width: 200, height: 50, alignment: .center)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

extension View {
    func getNavigationTitle(title: String) -> some View {
        if #available(iOS 14.0, *) {
            return navigationTitle(title)
        } else {
            return navigationBarTitle(title)
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
