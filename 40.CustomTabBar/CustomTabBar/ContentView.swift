//
//  ContentView.swift
//  CustomTabBar
//
//  Created by Cain Luo on 2024/1/23.
//

import SwiftUI

struct ContentView: View {
    @State var selectedIndex = 0
    @State var presented = false
    
    let icons = [
        "house",
        "gear",
        "plus",
        "lasso",
        "message"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Spacer().fullScreenCover(isPresented: $presented, content: {
                    Button(action: {
                        presented.toggle()
                    }, label: {
                        Text("Close")
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                })
                
                switch selectedIndex {
                case 0:
                    HomeView()
                case 1:
                    NavigationView {
                        VStack {
                            Text("First Screen")
                        }
                        .navigationTitle("Settings")
                    }

                case 2:
                    NavigationView {
                        VStack {
                            Text("First Screen")
                        }
                        .navigationTitle("Add")
                    }

                case 3:
                    NavigationView {
                        VStack {
                            Text("First Screen")
                        }
                        .navigationTitle("Edit")
                    }
                default:
                    NavigationView {
                        VStack {
                            Text("Second Screen")
                        }
                        .navigationTitle("Message")
                    }
                }
            }
            
            Spacer()
            
            Divider()
                .padding(.bottom, 20)
            HStack {
                ForEach(0..<5, id: \.self) { number in
                    Spacer()
                    Button(action: {
                        if number == 2 {
                            presented.toggle()
                        } else {
                            selectedIndex = number
                        }
                    }, label: {
                        if number == 2 {
                            Image(systemName: icons[number])
                                .frame(width: 60, height: 60)
                                .font(.system(size: 25,
                                              weight: .regular))
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(30)
                        } else {
                            Image(systemName: icons[number])
                                .font(.system(size: 25,
                                              weight: .regular))
                                .foregroundColor(selectedIndex == number ? .black : Color(UIColor.lightGray))
                        }
                    })
                    Spacer()
                }
            }
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("First Screen")
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
}
