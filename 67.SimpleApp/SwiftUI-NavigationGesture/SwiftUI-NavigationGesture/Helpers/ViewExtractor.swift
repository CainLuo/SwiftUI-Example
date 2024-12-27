//
//  ViewExtractor.swift
//  SwiftUI-NavigationGesture
//
//  Created by Cain on 2024/11/29.
//

import SwiftUI

extension View {
    @ViewBuilder
    func viewExtractor(result: @escaping (UIView) -> ()) -> some View {
        self
            .background(ViewExtractorHelper(result: result))
            .compositingGroup()
    }
}

fileprivate struct ViewExtractorHelper: UIViewRepresentable {
    var result: (UIView) -> ()

    /// 5.The composite group combines both the given SwiftUI view and the extractor background view.
    /// The logic here is that the two superview properties provide the composited grouped view. Since our SwiftUI view is at the top of the group, we can access it using the last subview property, Each SwiftUI view serves as a wrapper around a UIKit view. Consequently, the initial view will be a wrapper, and within it lies an actual associated UIKit view.
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            if let superview = view.superview?.superview?.subviews.last?.subviews.first {
                result(superview)
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
