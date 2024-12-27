//
//  Snapshot.swift
//  SwiftUI-ConvertViewToAnImage
//
//  Created by Cain on 2024/11/1.
//

import SwiftUI

extension View {
    @ViewBuilder
    func snapshot(trigger: Bool, onComplete: @escaping (UIImage) -> ()) -> some View {
        self
            .modifier(SnapshotModifier(trigger: trigger, onComplete: onComplete))
    }
}

fileprivate struct SnapshotModifier: ViewModifier {
    var trigger: Bool
    var onComplete: (UIImage) -> ()
    /// Local View Modifier Properties
    @State private var view: UIView = .init(frame: .zero)
    func body(content: Content) -> some View {
        if #available(iOS 17, *) {
            content
                .background(ViewExtractor(view: view))
            /// Now that we found the appropriate UIView, we can use this with UIGraphicsImageRenderer to create a snapshot image.
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
    
    /// As you can see when traversing using the superview property, it just wnet straight up to the root view and not the desired view. To solve this, we can use the compostingGroup modifier.
}

fileprivate struct ViewExtractor: UIViewRepresentable {
    var view: UIView
    
    func makeUIView(context: Context) -> UIView {
        view.backgroundColor = .clear
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

//#Preview {
//    ContentView()
//}

