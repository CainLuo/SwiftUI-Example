//
//  ContentView.swift
//  Menus
//
//  Created by Cain Luo on 2024/1/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                Text("Hello, world!")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Menu {
                                Button(action: {}, label: {
                                    Label(
                                        title: { Text("Add file") },
                                        icon: { Image(systemName: "doc") }
                                    )
                                })
                                
                                Button(action: {}, label: {
                                    Label(
                                        title: { Text("Rate App") },
                                        icon: { Image(systemName: "star") }
                                    )
                                })

                                Button(action: {}, label: {
                                    Label(
                                        title: { Text("Settings") },
                                        icon: { Image(systemName: "gear") }
                                    )

                                })
                                
                                Button(action: {}, label: {
                                    Label(
                                        title: { Text("Privacy Policy") },
                                        icon: { Image(systemName: "hand.raised") }
                                    )
                                })
                                
                                Menu {
                                    Button(action: {}, label: {
                                        Text("Option 1")
                                    })

                                    Button(action: {}, label: {
                                        Text("Option 2")
                                    })
                                } label: {
                                    Text("More Options")
                                }
                            } label: {
                                Label(
                                    title: { Text("Add") },
                                    icon: { Image(systemName: "plus") }
                                )
                            }

                        }
                    }
            }
            .navigationTitle("SwiftUI Menu")
        }
    }
}

#Preview {
    ContentView()
}
