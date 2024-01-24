//
//  ContentView.swift
//  DisclosureGroup
//
//  Created by Cain Luo on 2024/1/24.
//

import SwiftUI

struct ContentView: View {
    @State var isExpanded = false
    @State var isPrivacyExpanded = false
    @State var isTermsExpanded = false

    var body: some View {
        NavigationView {
            VStack {
                DisclosureGroup("Legal Stuff",
                                isExpanded: $isExpanded) {
                    
                    DisclosureGroup("Privacy Policy & Terms",
                                    isExpanded: $isTermsExpanded) {
                        Text("There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. ")
                            .multilineTextAlignment(.leading)
                    }
                                    .padding()

                    DisclosureGroup("Privacy Policy & Terms",
                                    isExpanded: $isPrivacyExpanded) {
                        Text("There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. There are our terms. ")
                            .multilineTextAlignment(.leading)
                    }
                                    .padding()
                }
                                .padding()

                Spacer()
            }
            .navigationTitle("Disclosure Group")
        }
    }
}

#Preview {
    ContentView()
}
