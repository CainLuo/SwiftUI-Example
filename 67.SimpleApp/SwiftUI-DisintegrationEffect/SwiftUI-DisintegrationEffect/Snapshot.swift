//
//  Snapshot.swift
//  SwiftUI-DisintegrationEffect
//
//  Created by Cain on 2024/11/22.
//

import SwiftUI

/// 1.For the snapshot, I'll use one of my previous video implementations. For more information, please refer to the link provided in the description.
extension View {
    @ViewBuilder
    func snapshot(trigger: Bool, onComplete: @escaping (UIImage) -> ()) -> some View {
        self
            .modifier(SnaphotModifier(trigger: trigger, onComplete: onComplete))
    }
}

fileprivate struct SnaphotModifier: ViewModifier {
    var trigger: Bool
    var onComplete: (UIImage) -> ()
    /// Local View Modifier Properties
    @State private var view: UIView = .init(frame: .zero)
    
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .background(ViewExtractor(view: view))
                .compositingGroup()
                .onChange(of: trigger) { oldValue, newValue in
                    generateSnapshot()
                }
        } else {
            content
                .background(ViewExtractor(view: view))
                .compositingGroup()
                .onChange(of: trigger) { newValue in
                    generateSnapshot()
                }
        }
    }

    private func generateSnapshot() {
        if let superView = view.superview?.superview {
            let renderer = UIGraphicsImageRenderer(size: superView.bounds.size)
            let image = renderer.image { _ in
                superView.drawHierarchy(in: superView.bounds, afterScreenUpdates: true)
            }
            onComplete(image)
        }
    }
}

fileprivate struct ViewExtractor: UIViewRepresentable {
    var view: UIView
    func makeUIView(context: Context) -> some UIView {
        view.backgroundColor = .clear
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    ContentView()
}
