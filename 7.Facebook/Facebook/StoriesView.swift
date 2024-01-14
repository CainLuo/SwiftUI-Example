//
//  StoriesView.swift
//  Facebook
//
//  Created by Cain Luo on 2023/12/22.
//

import SwiftUI

struct StoriesView: View {
    
    let stories: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 3) {
                ForEach(stories, id: \.self) { name in
                    Image(systemName: name)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 140, height: 200, alignment: .center)
                        .background(Color.gray)
                        .clipped()
                }
            }
            .padding()
        }
    }
}

#Preview {
    StoriesView(stories: ["123", "321", "312"])
}
