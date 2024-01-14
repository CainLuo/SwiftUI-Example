//
//  WidgetsExampleExtensionLiveActivity.swift
//  WidgetsExampleExtension
//
//  Created by Cain Luo on 2023/12/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetsExampleExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetsExampleExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetsExampleExtensionAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WidgetsExampleExtensionAttributes {
    fileprivate static var preview: WidgetsExampleExtensionAttributes {
        WidgetsExampleExtensionAttributes(name: "World")
    }
}

extension WidgetsExampleExtensionAttributes.ContentState {
    fileprivate static var smiley: WidgetsExampleExtensionAttributes.ContentState {
        WidgetsExampleExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetsExampleExtensionAttributes.ContentState {
         WidgetsExampleExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetsExampleExtensionAttributes.preview) {
   WidgetsExampleExtensionLiveActivity()
} contentStates: {
    WidgetsExampleExtensionAttributes.ContentState.smiley
    WidgetsExampleExtensionAttributes.ContentState.starEyes
}
