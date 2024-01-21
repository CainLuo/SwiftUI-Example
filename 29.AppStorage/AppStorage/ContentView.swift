//
//  ContentView.swift
//  AppStorage
//
//  Created by Cain Luo on 2024/1/21.
//

import SwiftUI

struct Settings {
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let isSubscribedKey = "isSubscriber"
}

struct ContentView: View {
    @AppStorage(Settings.firstNameKey) var firstName = ""
    @AppStorage(Settings.lastNameKey) var lastName = ""
    @AppStorage(Settings.isSubscribedKey) var isSubscriber = false

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
                        Toggle("Is Subscribed", isOn: $isSubscriber)
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
