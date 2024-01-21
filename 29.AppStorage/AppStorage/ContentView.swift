//
//  ContentView.swift
//  AppStorage
//
//  Created by Cain Luo on 2024/1/21.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("firstName") var firstName = ""
    @AppStorage("lastName") var lastName = ""
    @AppStorage("isSubscribed") var isSubscribed = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Detals")) {
                        TextField("First Name",
                                  text: $firstName)
                        TextField("Last Name",
                                  text: $lastName)
                    }
                    
                    Section(header: Text("Member Status")) {
                        Toggle("Is Subscribed", isOn: $isSubscribed)
                    }
                }
            }
            .navigationTitle("App Storage")
        }
    }
}

#Preview {
    ContentView()
}
