//
//  ContentView.swift
//  SwiftUI-CustomTabBarItem
//
//  Created by Cain on 2024/11/1.
//

import SwiftUI

@Observable
class TabarData {
    var hiddenTabbar: Bool = false
}

struct ContentView: View {
    @State private var activeTab: TabValue = .home
    @State private var symbolEffectTrigger: TabValue?
    
    /// SceneStorage is now working on previews, thus using Simulator.
    /// Type: 1
    // @SceneStorage("hideTabBar") private var hiddenTabbar: Bool = false
    /// Type: 2
    var tabbarData = TabarData()
    var body: some View {
        TabView(selection: .init(get: {
            activeTab
        }, set: { newValue in
            activeTab = newValue
            symbolEffectTrigger = newValue

            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                /// So what this will do is when ever the tab gets clicked, it will animate the icon with a symbol effect, and the next change won't be animated since we explicityl disabled animation for that action.
                /// Thus animating the currently tapped icon only once.
                symbolEffectTrigger = nil
            }
        })) {
            /// This will only remove the tab labels from the tab bar, and the tab bar and its actions will be still present, and by doing this we can overlay our customized tab buttons to the tab bar.
            Tab("Home", systemImage: "house", value: .home) {
//                Text("Home")
//                DummyScrollView()
                /// Now, I just showed you how you can customize your tab bar labels without sacrificing any of it's default behavior. Now let's add some cute symbol effects to each of it;s tab icons (each individual tab icon will have different symbol effects).
                TextField("Message", text: .constant(""))
                    .overlay(alignment: .topTrailing) {
                        Button("Hidden TabBar") {
                            /// This can be simply resolevd using two ways:
                            /// 1.By taking advantage of SceneStorge Wrapper.
                            /// Since SceneStorge will work in any view, you can update the tabbar visibility from any where
                            /// 2.Sometimes we don't want those state restoration features, or sometimes we want to update the tab bar visible status outside of the view's scope, such as Model, View Model, etc. For those instances, we can see @Observable to create a class that can be shared across all the tab child views and use it to update the tab bar visibility.
                            tabbarData.hiddenTabbar.toggle()
                        }
                        .foregroundStyle(.white)
                        .padding(25)
                    }
                    .toolbarVisibility(tabbarData.hiddenTabbar ? .hidden : .visible, for: .tabBar)
            }
            
            Tab(value: .search) {
                Text("Search")
            }

            Tab(value: .settings) {
                Text("Setting")
            }
        }
        .environment(tabbarData)
        .overlay(alignment: .bottom) {
            AnimatedTabBar()
                .opacity(tabbarData.hiddenTabbar ? 0 : 1)
        }
        /// For more videos, like this, please do like and subscribe to the channel.
        /// Have a great day, Folks!
        .ignoresSafeArea(.keyboard, edges: .all)
    }
    
    @ViewBuilder
    func AnimatedTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(TabValue.allCases, id: \.rawValue) { tab in
                VStack(spacing: 4) {
                    Image(systemName: tab.symbolImage)
                        .font(.title2)
                        .symbolVariant(.fill)
                    /// This little simple custom modifier allows me to choose modifiers depending on conditions (such as if, switch, etc.).
                        .modifiers { content in
                            switch tab {
                                /// We still didn't address one of it's main issues: when the tabbar is hidden from the tab view using the toolBarVisibility modifier, those customized icons will be still visible. Let me show you an example.
                            case .home: content
                                    .symbolEffect(.bounce.byLayer.down, options: .speed(1.2), value: symbolEffectTrigger == tab)
                            case .search: content
                                    .symbolEffect(.wiggle.counterClockwise, options: .speed(1.4), value: symbolEffectTrigger == tab)
                            case .settings: content
                                    .symbolEffect(.rotate.byLayer, options: .speed(2), value: symbolEffectTrigger == tab)
                            }
                        }
 
                    Text(tab.rawValue)
                        .font(.caption2)
                }
                .foregroundStyle(activeTab == tab ? .blue : .secondary)
                .frame(maxWidth: .infinity)
            }
        }
        /// We just want to display our lables with customizations and not interrupt with the underlaying tab bar actions, so I explicitly disabled it's user interaction.
        .allowsHitTesting(false)
        /// This is the most ideal tab bar height used by the default systems.
        .frame(height: 48)
    }
    
    @ViewBuilder
    func DummyScrollView() -> some View {
        ScrollView {
            VStack {
                ForEach(1...50, id: \.self) { _ in
                    Rectangle()
                        .frame(height: 50)
                }
            }
            .padding()
        }
    }
    
    
    /// There is one last thing we need to do, since the customed icons added as an overlay to the tab view, it will move around when a keyboard becomes active.
    /// To solve this, simply use the .ignoreSafeArea(.keyboard) modifier.
}

extension View {
    @ViewBuilder
    func modifiers<Content: View>(@ViewBuilder content: @escaping (Self) -> Content) -> some View {
        content(self)
    }
}

enum TabValue: String, CaseIterable {
    case home = "Home"
    case search = "Search"
    case settings = "Settings"
    
    var symbolImage: String {
        switch self {
        case .home: "house"
        case .search: "magnifyingglass"
        case .settings: "gearshape"
        }
    }
}

//#Preview {
//    ContentView()
//}
