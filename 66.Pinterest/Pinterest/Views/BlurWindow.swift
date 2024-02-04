//
//  BlurWindow.swift
//  Pinterest
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI

struct BlurWindow: NSViewRepresentable {
    typealias NSViewType = NSVisualEffectView

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.blendingMode = .behindWindow
        
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        
    }    
}

#Preview {
    BlurWindow()
}
