//
//  ContentView.swift
//  iOSAcademy
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI

struct Option: Hashable {
    let title: String
    let imageName: String
}

struct ContentView: View {
    @State var currentOption = 0
    
    let options: [Option] = [
        Option(title: "Home", imageName: "house"),
        Option(title: "About", imageName: "info.circle"),
        Option(title: "Settings", imageName: "gear"),
        Option(title: "Social", imageName: "message")
    ]
    
    var body: some View {
        NavigationView {
            ListView(
                options: options,
                currentSelection: $currentOption
            )
            
            switch currentOption {
            case 1:
                Text("About iOS Academy View")
            default:
                MainView()
            }
        }
        .frame(minWidth: 600, minHeight: 400)
    }
}

struct MainView: View {
    let cols: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    let videoImages = Array(1...6).map { "video\($0)" }
    
    var body: some View {
        VStack {
            Image("header")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.pink)
                .frame(width: 600, height: 300)
            
            LazyVGrid(columns: cols, content: {
                ForEach(videoImages, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.blue)
                }
            })
            
            Spacer()
        }
    }
}

struct ListView: View {
    let options: [Option]
    @Binding var currentSelection: Int

    var body: some View {
        VStack {
            let current = options[currentSelection]
            
            ForEach(options, id: \.self) { option in
                HStack {
                    Image(systemName: option.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    Text(option.title)
                        .foregroundColor(current == option ? Color.blue : Color.white)
                    
                    Spacer()
                }
            }
            .padding(8)
            .onTapGesture {
                if currentSelection == 1 {
                    self.currentSelection = 0
                } else {
                    self.currentSelection = 1
                }
            }
        }
        Spacer()
    }
}

#Preview {
    ContentView()
}
