//
//  ContentView.swift
//  Links
//
//  Created by Cain Luo on 2024/1/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Link(destination: URL(string: "https://www.google.com")!, label: {
                    Label(
                        title: { 
                            Text("Search Google")
                                .bold()
                        },
                        icon: { 
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 22, weight: .bold))
                        }
                    )
                    .frame(width: 250, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                })
                
                Link(destination: URL(string: "googlamap://")!, label: {
                    Label(
                        title: {
                            Text("Google Map ->")
                                .bold()
                        },
                        icon: {
                            Image(systemName: "safari")
                                .font(.system(size: 22, weight: .bold))
                        }
                    )
                    .frame(width: 250, height: 50)
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                })

                Link(destination: URL(string: "applestore://")!, label: {
                    Label(
                        title: {
                            Text("Apple Store")
                                .bold()
                        },
                        icon: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 22, weight: .bold))
                        }
                    )
                    .frame(width: 250, height: 50)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                })
                
                Spacer()
            }
            .navigationTitle("Links")
        }
    }
}

#Preview {
    ContentView()
}
