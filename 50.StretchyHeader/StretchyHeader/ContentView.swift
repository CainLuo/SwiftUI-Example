//
//  ContentView.swift
//  StretchyHeader
//
//  Created by Cain Luo on 2024/1/27.
//

import SwiftUI

struct CardData {
    let id: Int
    let title: String
}

struct ContentView: View {
    let appName = ["Doodle Jump", "Subway Surfers", "Asphalt Racing", "Super Mario", "Cut the Rope"]
    
    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { proxy in
                    let global = proxy.frame(in: .global)
                    
                    // Poster image
                    Image(systemName: "house")
                        .resizable()
                        .frame(
                            height: global.maxY > 0 ?
                            (UIScreen.main.bounds.size.height / 2.2) + global.minY :
                            UIScreen.main.bounds.size.height / 2.2
                        )
                        .background(Color.blue)
                        .offset(y: global.minY > 0 ? -global.minY : 0)
                }
                .frame(height: UIScreen.main.bounds.size.height / 2.2)

                VStack {
                    ForEach(1...5, id: \.self) { num in
                        let data = CardData(
                            id: num, 
                            title: self.appName[num - 1]
                        )
                        
                        CardView(data: data)
                            .padding()
                    }
                }
            }
        }
    }
}

struct CardView: View {
    
    let data: CardData
    
    var body: some View {
        HStack {
            Image(systemName: "house")
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(data.title + "\(data.id)")
                    .bold()
                    .font(.system(size: 24))
                    .padding(3)
                
                Text("Offers In-App Purchases")
                    .bold()
                    .font(.system(size: 17))
            }
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Text("GET")
                    .padding()
                    .foregroundColor(.blue)
                    .background(Color(.systemGray6))
                    .cornerRadius(6)
            })
        }
    }
}

#Preview {
    ContentView()
}
