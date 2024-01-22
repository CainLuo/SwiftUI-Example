//
//  ContentView.swift
//  Redacted
//
//  Created by Cain Luo on 2024/1/22.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(0...10, id: \.self) { _ in
                        PostView()
                            .frame(height: 150)
                            .padding(12)
                    }
                }
                .redacted(reason: isLoading ? .placeholder : [])
            }
            .navigationTitle("Redacted")
            .onAppear(perform: {
                fetchData()
            })
        }
    }
    
    func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            isLoading = false
        }
    }
}

struct PostView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55, height: 55)
                
                Text("HagenDashi")
                    .bold()
                    .font(.system(size: 22))
            }
            
            Text("This is a supper duper long post with a bit of text for this awesome SwiftUI video!")
                .font(.system(size: 24))
        }
    }
}

#Preview {
    ContentView()
}
