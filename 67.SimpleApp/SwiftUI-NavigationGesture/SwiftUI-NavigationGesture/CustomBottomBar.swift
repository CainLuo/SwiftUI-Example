//
//  CustomBottomBar.swift
//  SwiftUI-NavigationGesture
//
//  Created by Cain on 2024/11/28.
//

import SwiftUI

/// 1.This is a simple implementation of a view with a navigation stack and a tab bar.
struct CustomBottomBar: View {
    @Environment(NavigationHelper.self) private var navigationHelper
    @State private var selectedTab: TabModel = .home
    var body: some View {
        HStack(spacing: 0) {
            let blur = (1 - navigationHelper.popProgress) * 3
            let scale = (1 - navigationHelper.popProgress) * 0.1

            ForEach(TabModel.allCases, id: \.rawValue) { tab in
                Button {
                    if tab == .newPost {
                        
                    } else {
                        selectedTab = tab
                    }
                } label: {
                    Image(systemName: tab.rawValue)
                        .font(.title3)
                        .foregroundStyle(selectedTab == tab || tab == .newPost ? Color.primary : Color.gray)
                        /// 4.It's not complete yet. We still want to fade in/out the control when the interactive pop gesture is active. To achieve this, we need to know the interactive pop gesture's progress value. Currently, there's no native SwiftUI way to retrieve that. So, I'll create a helper extension that extracts the associated UIKit view from the given SwiftUI View and then uses it to extract the progress value.
                        .blur(radius: tab != .newPost ? blur : 0)
                        .scaleEffect(tab == .newPost ? 1.5 : 1 - scale)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .contentShape(.rect)
                }
                .opacity(tab != .newPost ? navigationHelper.popProgress : 1)
                .overlay {
                    ZStack {
                        if tab == .home {
                            Button {
                                
                            } label: {
                                Image(systemName: "exclamationmark.bubble")
                                    .font(.title3)
                                    .foregroundStyle(Color.primary)
                            }
                        }

                        if tab == .settings {
                            Button {
                                
                            } label: {
                                Image(systemName: "ellipsis")
                                    .font(.title3)
                                    .foregroundStyle(Color.primary)
                            }
                        }
                    }
                    .opacity(1 - navigationHelper.popProgress)
                }
            }
        }
        /// 3.Bu using this simple logic, you can determine whether the view is pushed or popped.
        .onChange(of: navigationHelper.path) { oldValue, newValue in
            guard newValue.isEmpty || oldValue.isEmpty else { return }
            if newValue.count > oldValue.count {
                navigationHelper.popProgress = 0.0
            } else {
                navigationHelper.popProgress = 1.0
            }
        }
        .animation(.easeInOut(duration: 0.25), value: navigationHelper.popProgress)
    }
}

enum TabModel: String, CaseIterable {
    case home = "house.fill"
    case search = "magnifyingglass"
    case newPost = "square.and.pencil.circle.fill"
    case notifications = "bell.fill"
    case settings = "gearshape.fill"
}

#Preview {
    ContentView()
}
