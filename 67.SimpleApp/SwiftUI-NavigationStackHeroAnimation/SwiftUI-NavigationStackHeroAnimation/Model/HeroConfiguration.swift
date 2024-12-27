//
//  HeroConfiguration.swift
//  SwiftUI-NavigationStackHeroAnimation
//
//  Created by Cain on 2024/11/25.
//

import Foundation

/// 3.In my example, the layer is an image, so I'm passing it as a string because it's an asset image. In your case, it could be a UIImage, color, symbol image, or something else. Therefore, update it according to your requirements.
struct HeroConfiguration {
    var layer: String?
    /// 4.This property stores the source and destination coordinates for animating the layer's position from its source location to its destination location.
    var coordinates: (CGRect, CGRect) = (.zero, .zero)
    var isExpandedCompletely: Bool = false
    var activeID: String = ""
}
