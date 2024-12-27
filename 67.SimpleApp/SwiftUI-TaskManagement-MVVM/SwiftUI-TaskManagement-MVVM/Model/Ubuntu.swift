//
//  Ubuntu.swift
//  SwiftUI-TaskManagement-MVVM
//
//  Created by Cain on 2024/12/9.
//

import SwiftUI

// MARK: Custom Font Extension
enum Ubuntut {
    case light
    case bold
    case medium
    case regular

    var weight: Font.Weight {
        switch self {
        case .light:
            return .light
        case .bold:
            return .bold
        case .medium:
            return .medium
        case .regular:
            return .regular
        }
    }
}

extension View {
    func ubuntu(_ size: CGFloat, _ weight: Ubuntut) -> some View {
        self
            .font(.custom("Ubuntu", size: size))
            .fontWeight(weight.weight)
    }
}
