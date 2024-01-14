//
//  ContentView.swift
//  Facebook
//
//  Created by Cain Luo on 2023/12/22.
//

import SwiftUI

struct FBPostModel: Hashable {
    let name: String
    let post: String
    let imageName: String
}

struct ContentView: View {
    
    @Binding var text: String
    
    let posts = [
        FBPostModel(name: "Mark Zukerberg",
                    post: "Hey，Facebook是我见过所有App中最好的。",
                    imageName: "person.circle"),
        FBPostModel(name: "Justin Bieber",
                    post: "想一下下一站的演唱会去哪里开比较好。",
                    imageName: "person.circle"),
        FBPostModel(name: "Mark Zukerberg",
                    post: "Hey，Facebook是我见过所有App中最好的。",
                    imageName: "person.circle")
    ]
    
    let stories = ["person.circle",
                   "eraser.line.dashed",
                   "square.and.pencil",
                   "person.circle",
                   "eraser.line.dashed",
                   "square.and.pencil"]
    let facebookBlue = UIColor(red: 23/255.0,
                               green: 120/255.0,
                               blue: 242/255.0,
                               alpha: 1)
    
    var body: some View {
        VStack  {
            HStack {
                Text("facebook")
                    .font(.system(size: 48, weight: .bold, design: .default))
                    .foregroundColor(Color(facebookBlue))
                
                Spacer()
                
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 45, height: 45, alignment: .center)
                    .foregroundColor(Color(.secondaryLabel))
            }
            .padding()
            
            TextField("Search...", text: $text)
                .padding(7)
                .background(Color(.systemGray5))
                .cornerRadius(7)
                .padding(.horizontal, 15)
            
            Spacer()
            
            ZStack {
                Color(.secondarySystemBackground)
                
                ScrollView(.vertical) {
                    VStack {
                        
                        StoriesView(stories: stories)
                        
                        ForEach(posts, id: \.self) { model in
                            FBPost(model: model)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(text: .constant(""))
}
