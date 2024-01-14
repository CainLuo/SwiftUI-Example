//
//  ContentView.swift
//  WebView
//
//  Created by Cain Luo on 2023/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            SwiftUIWebView(url: URL(string: "https://www.apple.com.cn"))
                .navigationTitle("WKWebView")
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

#Preview {
    ContentView()
}
