//
//  ContentView.swift
//  CoolIcons
//
//  Created by Cain Luo on 2024/1/15.
//

import SwiftUI
import SwiftUIFontIcon

struct ContentView: View {
    @State var updateBg = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Material Icon (Assistant)")
                    Spacer()
                    FontIcon.text(.materialIcon(code: .assistant), fontsize: 45, color: .blue)
                }
                .padding()
                
                HStack {
                    Text("Material Icon (Sync)")
                    Spacer()
                    FontIcon.text(.materialIcon(code: .sync), fontsize: 45, color: .green)
                }
                .padding()

                HStack {
                    Text("Ionicon Button (Add)")
                    Spacer()
                    FontIcon.button(.ionicon(code: .ios_add_circle), 
                                    action: {
                            self.updateBg.toggle()
                        },
                                    fontsize: 45,
                                    color: .pink)
                }
                .padding()
                
                Spacer()
            }
            .background(updateBg ? Color.pink : Color(.systemBackground))
            .navigationTitle("Custom Icons")
        }
    }
}

#Preview {
    ContentView()
}
