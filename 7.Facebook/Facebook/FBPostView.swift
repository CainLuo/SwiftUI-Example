//
//  FBPostView.swift
//  Facebook
//
//  Created by Cain Luo on 2023/12/22.
//

import SwiftUI

struct FBPost: View {
    
    @State var isLiked: Bool = false
    
    let model: FBPostModel

    var body: some View {
        VStack {
            HStack {
                Image(systemName: model.imageName)
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(25)
                VStack {
                    HStack {
                        Text(model.name)
                            .foregroundColor(Color.blue)
                            .font(.system(size: 18,
                                          weight: .semibold,
                                          design: .default))
                        Spacer()
                    }
                    HStack {
                        Text("12 minutes ago")
                            .foregroundColor(Color(.secondaryLabel))
                        Spacer()
                    }
                }
                Spacer()
            }
            HStack {
                Text(model.post)
                    .font(.system(size: 24, weight: .regular, design: .default))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            Spacer()

            HStack {
                Button(action: {
                    isLiked.toggle()
                }, label: {
                    Text(isLiked ? "Liked" : "Like")
                })
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("Commont")
                })

                Spacer()

                Button(action: {}, label: {
                    Text("Share")
                })
            }
            .padding()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(7)
    }
}

#Preview {
    FBPost(model: FBPostModel(name: "123123", 
                              post: "123213",
                              imageName: "213213"))
}
