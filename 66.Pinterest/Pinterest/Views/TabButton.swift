//
//  TabButton.swift
//  Pinterest
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI

struct TabButton: View {
    var image: String
    var title: String
    
    var animation: Namespace.ID
    
    @Binding var selected: String
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selected = title
            }
        }, label: {
            HStack {
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(selected == title ? Color.black : black)
                    .frame(width: 25)
                
                Text(title)
                    .fontWeight(selected == title ? .semibold : .none)
                    .foregroundColor(selected == title ? Color.black : black)
                    .animation(.none)
                
                Spacer()
                
                // Capsule...
                ZStack {
                    Capsule()
                        .fill(Color.clear)
                        .frame(width: 3, height: 25)
                    
                    if selected == title {
                        Capsule()
                            .fill(Color.black)
                            .frame(width: 3, height: 25)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            }
            .padding(.leading)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

var black = Color.black.opacity(0.5)
