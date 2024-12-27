//
//  Home.swift
//  SwiftUI-NavigationStackHeroAnimation
//
//  Created by Cain on 2024/11/25.
//

import SwiftUI

struct Home: View {
    /// Hero Configuration
    @State private var config = HeroConfiguration()
    @State private var selectedProfile: Profile?
    var body: some View {
        NavigationStack {
            List {
                ForEach(profiles) { profile in
                    ProfileCardView(profile: profile, config: $config) { rect in
                        config.coordinates.0 = rect
                        config.coordinates.1 = rect
                        config.layer = profile.profilePicture
                        config.activeID = profile.id
                        /// This is used for navigationDestina
                        selectedProfile = profile
                    }
                }
            }
            .navigationTitle("Messages")
            .manageHomeForOlderiOSVersion()
            .navigationDestination(item: $selectedProfile) { profile in
                DetailView(selectedProfile: $selectedProfile, profile: profile, config: $config)
            }
        }
        /// 8.Place the overlay above the NavigationStack, not within it, or it will also be pushed away when navigating to other views.
        .overlay(alignment: .topLeading) {
            ZStack {
                if let image = config.layer {
                    let destination = config.coordinates.1
                    
                    Image(systemName: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: destination.width, height: destination.height)
                        .clipShape(.circle)
                        .offset(x: destination.minX, y: destination.minY)
                        .transition(.identity)
                        .onDisappear {
                            /// Resetting Configuration
                            /// 13.As you can observe, the destination view isn't being hidden when it's being popped back. This is because when the view is being popped out, the state changes aren't being reflected. To fix this, let's pass the selectedProfile binding to the detail view and remove the view immediately if its value is nil.
                            config = .init()
                        }
                }
            }
            /// 10.Once the animation is complete, ensure that the destination view is visible, and the layer view is hidden.
            .animation(.snappy(duration: 0.3, extraBounce: 0), value: config.coordinates.1)
            .ignoresSafeArea()
            .opacity(config.isExpandedCompletely ? 0 : 1)
            /// 11.Now, the primary question is how we can determine when the view is about  to pop up. Starting from iOS 18, the presentation value, which is selectedProfile, will immediately set to nil when the view is about to pop. Therefore, we can utilize the onChange modifier to predict when the view will pop and reset the layer view to its original location.
            .onChange(of: selectedProfile == nil) { oldValue, newValue in
                /// 12. Here are two important notes:
                ///  1.Avoid using spring-based animations for dismissals because they won't be immediately removed from the screen.
                ///  2. Do not exceed an animation duration of 0.35 seconds, as the maximum time of the navigation stack for pushing or popping views is 0.35s.
                if newValue {
                    /// 13.As I mentioned earlier, the selection value becoming nil is a new thing in iOS 18. For previous versions, the value would be reset only when the view is completely dismissed. To address this issue, we can simply remove the navigation bar and create a custom back button. This approach will also eliminate the interactive dismissal behavior, but at least we have a working hero effect on iOS 17 version.
                    config.isExpandedCompletely = false

                    withAnimation(.easeInOut(duration: 0.35), completionCriteria: .logicallyComplete) {
                        config.coordinates.1 = config.coordinates.0
                    } completion: {
                        config.layer = nil
                    }
                }
            }
        }
        /// 9.The core logic is simple. Whenever a new view is pushed, I'll store its location in both the source and destination properties. When the detail view is pushed, the destination coordinate will be updated, causing the layer view to smoothly transition from the source to the destination location. After the push is complete(which will averagely take 0.35 seconds), the layer view will be hidden. Once the detail view is about to pop, I'll reset the layer's position back to the source location. After the animation is complete, I'll remove all the configuration properties.
    }
}

/// 5.Create a simple card view that displays my message on the right side with a blue tint and replies on the left side with a gray tint.
/// Message Card View
struct MessageCardView: View {
    var message: Message
    var body: some View {
        Text(message.message)
            .padding(10)
            .foregroundStyle(message.isReply ? Color.primary : .white)
            .background {
                if message.isReply {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray.opacity(0.3))
                } else {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.blue.gradient)
                }
            }
            .frame(maxWidth: 250, alignment: message.isReply ? .leading : .trailing)
            .frame(maxWidth: .infinity, alignment: message.isReply ? .leading : .trailing)
    }
}

#Preview {
    Home()
}

extension View {
    @ViewBuilder
    func hideNavbarBackground() -> some View {
        if #available(iOS 18, *) {
            self
                .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        } else {
            self
                .toolbar(.hidden, for: .navigationBar)
                .navigationBarBackButtonHidden()
        }
    }
    
    @ViewBuilder
    func manageHomeForOlderiOSVersion() -> some View {
        if #available(iOS 18, *) {
            self
        } else {
            self
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}

/// 14.In this video, I demonstrated how to create a custom hero effect for the navigation stack in iOS 18+ versions without compromising its Interactive dismiss behavior. Additionally, we made it compatible with iOS 17 versions, but with a minor limitation: the removal of its default dismissal behavior.
/// I hope you enjoyed this video. For more SwiftUI content, subscribe to the Kavsoft Channel.
