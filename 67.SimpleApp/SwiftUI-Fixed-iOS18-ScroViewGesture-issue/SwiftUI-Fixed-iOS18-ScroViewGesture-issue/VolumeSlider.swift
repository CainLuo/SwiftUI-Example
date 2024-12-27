//
//  VolumeSlider.swift
//  SwiftUI-Fixed-iOS18-ScroViewGesture-issue
//
//  Created by Cain on 2024/11/27.
//

import SwiftUI

/// 1.This is a smaple code for a custom slider with gestures using SwiftUI.
struct VolumeSlider: View {
    @Binding var isScrollDisabled: Bool
    @State private var progress: CGFloat = 0
    @State private var lastProgress: CGFloat = 0
    @State private var velocity: CGSize = .zero
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                Rectangle()
                    .fill(.black)
                    .frame(width: progress * size.width)
            }
            .clipShape(.rect(cornerRadius: 10))
            /// 4.Starting with iOS 18, the simultaneousGesture will begin recognizing both gestures and scroll views simultaneously. This feature was not available before iOS 18. When using this, the slider is working but it also caused the scroll to occur simultaneously. To address this issue, we will utilize the velocity and isScrollDisabled properties.
            .simultaneousGesture(
                /// 2.Until iOS 18, this code functioned correctly within ScrollViews. However, in iOS 18, it blocks scroll interactions, as demonstrated in the introductory video. To address this issue, we have two methods:
                /// 2.1 Utilize a higher MinimumDistance value.
                
                /// 3.Since we've increased the minimumDistance value to 30, the translation value will now start at +/-30 (the default value is 10). Now, let's move on to the second method.
                /// Bu using the drag velocity and scrollDisabled modifier to make the translation start from 1 and also making it work with scrollviews.
                customGesture
                
                    /// 5.The reason we don't give 0 is that it won;t be triggered when we touch it. By giving a value of 1, it will only be triggered when the user moves their fingers apart from touching it.
                    .onChanged { value in
                        if #available(iOS 18, *) {
                            if velocity == .zero {
                                velocity = value.velocity
                            }
                            
                            guard velocity.height == 0 else { return }
                            
                            isScrollDisabled = true
                        }
                        let progress = (value.translation.width / size.width) + lastProgress
                        self.progress = max(min(progress, 1), 0)
                    }
                    .onEnded { _ in
                        lastProgress = progress
                        if #available(iOS 18, *) {
                            velocity = .zero
                            isScrollDisabled = false
                        }
                    }
            )
        }
        .frame(height: 40)
    }
    
    /// 6.Now, we've successfully made it work with iOS 18 as well. However, if you attempt to run this on iOS 17, theissue we encountered with iOS 18 will now manifest in iOS 17. This is because we modified the minimumDisatnce value. Consequently, you can now make it compatible with both iOS 18 and older versions by simply following the next few steps.
    var customGesture: DragGesture {
        if #available(iOS 18, *) {
            DragGesture(minimumDistance: 1)
        } else {
            DragGesture()
        }
    }
}

#Preview {
    ContentView()
}

/// 7.In this video, I showed you how to fix the gesture issue with iOS 18 devices. I hope you found it helpful!
/// If you're interested in more SwiftUI content, be sure to subscribe to our channel!
