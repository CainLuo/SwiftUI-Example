//
//  SwiftUIWebView.swift
//  Facebook
//
//  Created by Cain Luo on 2023/12/22.
//

import WebKit
import SwiftUI

struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        let webpagePreferences = WKWebpagePreferences()
        webpagePreferences.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = webpagePreferences
        
        return WKWebView(frame: .zero, configuration: configuration)
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = url else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
