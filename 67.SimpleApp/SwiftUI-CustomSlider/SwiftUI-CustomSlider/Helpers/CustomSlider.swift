//
//  CustomSlider.swift
//  SwiftUI-CustomSlider
//
//  Created by Cain on 2024/11/26.
//

import SwiftUI

struct CustomSlider<Overlay: View>: View {
    @Binding var value: CGFloat
    var range: ClosedRange<CGFloat>
    var config: Config
    var overlay: Overlay
    
    init(
        value: Binding<CGFloat>,
        in range: ClosedRange<CGFloat>,
        config: Config = .init(),
        @ViewBuilder overlay: @escaping () -> Overlay
    ) {
        self._value = value
        self.range = range
        self.config = config
        self.overlay = overlay()
        self.lastStoredValue = value.wrappedValue
    }

    /// View Properties
    @State private var lastStoredValue: CGFloat
    @GestureState private var isActive: Bool = false
    var body: some View {
        GeometryReader {
            let size = $0.size
            let width = (value / range.upperBound) * size.width
                        
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(config.inActiveTint)
                
                Rectangle()
                    .fill(config.activeTint)
                    .mask(alignment: .leading) {
                        Rectangle()
                            .frame(width: width)
                    }
                
                ZStack(alignment: .leading) {
                    /// 7.Now, let's create two overlay views. One will display with the inactive tint, and the other will display with the active tint. The overlay with the active tint will have the same masking layer as the progress bar color, making it visible under both active and inactive tints.
                    overlay
                        .foregroundStyle(config.overlayInActiveTint)
                    
                    overlay
                        .foregroundStyle(config.overlayActiveTint)
                        .mask(alignment: .leading) {
                            Rectangle()
                                .frame(width: width)
                        }
                }
                /// 8.The composting group will group the views, create a single view, and apply opacity to that view.
                .compositingGroup()
//                .opacity(isActive ? 1 : 0)
                /// 9.Now, let's modify the opacity animation to behave as follows: when expanding, it should show after a slight delay, and when closing, it should fade out faster than the usual animation.
                .animation(.easeInOut(duration: 0.3).delay(isActive ? 0.12 : 0).speed(isActive ? 1 : 2)) {
                    $0.opacity(isActive ? 1 : 0)
                    
                    /// 10.Hey folks!
                    /// If you enjoyed this video, please give it a thumbs up, share it with your friends, and don't forget to subscribe to our channel for more SwiftUI-based goodness.
                    /// Thanks a bunch!
                }
            }
//            .clipShape(.rect(cornerRadius: config.cornerRadius))
//            .contentShape(.rect(cornerRadius: config.cornerRadius))
            .contentShape(.rect)
            .highPriorityGesture(
                DragGesture(minimumDistance: 0)
                    .updating($isActive) { _, out, _ in
                        out = true
                    }
                    .onChanged { value in
                        /// 2.Sometimes, we may have already assigned a value greater than zero. In such cases, the progress must continue from that value rather than starting from the beginning. To address this issue, we can introduce a new variable that store the previous progress value. With this new variable, we can continue the progress wherever it left off previously.
                        let progress = ((value.translation.width / size.width) * range.upperBound) + lastStoredValue
//                        self.value = progress
                        
                        /// 4.Now that we have successfully created a custom slider progress, let's make it expandable.
                        self.value = max(min(progress, range.upperBound), range.lowerBound)
                    }
                    .onEnded { _ in
                        /// 3.Let's limit the progress value within the specified minimum and maximum values.
                        lastStoredValue = value
                    }
            )
        }
        /// 5.What I'm doing is simple. I've already set the frame to the expanded size and used the mask modifier to nimate the changes. Instead of directly changing the frame, I used this method because when we directly apply it to the frame, the bounds dynamically shift whenever the user interacts, and the view using this slider moves back and forth during interactions. However, this method ensure that the slider remains still and gives the expanding effect.
        .frame(height: 20 + config.extraHeight)
        .mask {
            RoundedRectangle(cornerRadius: config.cornerRadius)
                .frame(height: 20 + (isActive ? config.extraHeight : 0))
        }
        .animation(.snappy, value: isActive)
    }
    
    /// 1.You can add more properties as per your requirements.
    struct Config {
        var inActiveTint: Color = .black.opacity(0.06)
        var activeTint: Color = Color.primary
        var cornerRadius: CGFloat = 15
        var extraHeight: CGFloat = 25
        /// Overlay Properties
        var overlayActiveTint: Color = .white
        var overlayInActiveTint: Color = .black
    }
}

#Preview {
    ContentView()
}
