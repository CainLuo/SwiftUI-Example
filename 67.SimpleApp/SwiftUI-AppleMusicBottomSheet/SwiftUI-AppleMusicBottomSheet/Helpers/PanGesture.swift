//
//  PanGesture.swift
//  SwiftUI-AppleMusicBottomSheet
//
//  Created by Cain on 2024/10/29.
//

import SwiftUI

/// You can use this implementation in your other apps as well, and obviously it must be above iOS 18.0+
struct PanGesture: UIGestureRecognizerRepresentable {
    var onChange: ((Value) -> ())
    var onEnd: ((Value) -> ())
    
    func makeUIGestureRecognizer(context: Context) -> UIPanGestureRecognizer {
        let gesture = UIPanGestureRecognizer()
        return gesture
    }
    
    func updateUIGestureRecognizer(_ recognizer: UIPanGestureRecognizer, context: Context) {
    
    }
    
    func handleUIGestureRecognizerAction(_ recognizer: UIPanGestureRecognizer, context: Context) {
        let state = recognizer.state
        let translation = recognizer.translation(in: recognizer.view).toSize()
        let velocity = recognizer.velocity(in: recognizer.view).toSize()
        let value = Value(translation: translation, velocity: velocity)
        
        if state == .began || state == .changed {
            onChange(value)
        } else {
            onEnd(value)
        }
    }
    
    struct Value {
        var translation: CGSize
        var velocity: CGSize
    }
}

extension CGPoint {
    func toSize() -> CGSize {
        return .init(width: x, height: y)
    }
}
