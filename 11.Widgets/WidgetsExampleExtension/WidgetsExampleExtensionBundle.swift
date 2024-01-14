//
//  WidgetsExampleExtensionBundle.swift
//  WidgetsExampleExtension
//
//  Created by Cain Luo on 2023/12/26.
//

import WidgetKit
import SwiftUI

@main
struct WidgetsExampleExtensionBundle: WidgetBundle {
    var body: some Widget {
        WidgetsExampleExtension()
        WidgetsExampleExtensionLiveActivity()
    }
}
