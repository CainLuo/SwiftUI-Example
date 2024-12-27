#  Micro Interactions Tab Bar

We usually have a tab bar like this in our apps, and by default, the SwiftUI Tab button cannot be customized rom it's default one, and building a custom one all the native features(such as the tap the tab button to scroll to the top and rest navigation links, available only from iOS 18+) for all, so in this video, let's see how you can customize your tab buttons without scarifying nay of it's default features.

```swift
import SwiftUI

struct ContentView: View {
    @State private var activeTab: TabValue = .home
    var body: some View {
        TabView(selection: $activeTab) {
            Tab("Home", systemImage: "house", value: .home) {
                Text("Home")
            }

            Tab("Search", systemImage: "magnifyingglass", value: .search) {
                Text("Search")
            }

            Tab("Setting", systemImage: "gearshape", value: .settings) {
                Text("Setting")
            }
        }
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
```

This will only remove the tab labels from the tab bar, and the tab bar and its actions will be still present, and by doing this we can overlay our customized tab buttons to the tab bar.

```swift
TabView(selection: $activeTab) {
    Tab(value: .home) {
        Text("Home")
    }

    Tab(value: .search) {
        Text("Search")
    }

    Tab(value: .settings) {
        Text("Setting")
    }
}
```

We just want to display our lables with customizations and not interrupt with the underlaying tab bar actions, so I explicitly disabled it's user interaction.

```swift
@ViewBuilder
func AnimatedTabBar() -> some View {
    HStack(spacing: 0) {
        ForEach(TabValue.allCases, id: \.rawValue) { tab in
            VStack(spacing: 4) {
                Image(systemName: tab.symbolImage)
                    .font(.title2)
                    .symbolVariant(.fill) 
                Text(tab.rawValue)
                    .font(.caption2)
            }
            .foregroundStyle(activeTab == tab ? .blue : .secondary)
        }
    }
    .allowsHitTesting(false)
}
```

This is the most ideal tab bar height used by the default systems.

```swift
@ViewBuilder
func AnimatedTabBar() -> some View {
    HStack(spacing: 0) {
        ForEach(TabValue.allCases, id: \.rawValue) { tab in
            VStack(spacing: 4) {
                Image(systemName: tab.symbolImage)
                    .font(.title3)
                    .symbolVariant(.fill) 
                Text(tab.rawValue)
                    .font(.caption2)
            }
            .foregroundStyle(activeTab == tab ? .blue : .secondary)
            .frame(maxWidth: .infinity)
        }
    }
    .allowsHitTesting(false)
    .frame(height: 48)
}
```

Add Dumy Scroll View

```swift
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
```

Upgrade Tab View Home tab code:

```swift
Tab(value: .home) {
    DummyScrollView()
}
```

Now, I just showed you how you can customize your tab bar labels without sacrificing any of it's default behavior. Now let's add some cute symbol effects to each of it;s tab icons (each individual tab icon will have different symbol effects).

```swift
extension View {
    @ViewBuilder
    func modifiers<Content: View>(@ViewBuilder content: @escaping (Self) -> Content) -> some View {
        content(self)
    }
}
```

```swift
Image(systemName: tab.symbolImage)
    .font(.title3)
    .symbolVariant(.fill)
    .modifiers { content in
        content
    }
```

This little simple custom modifier allows me to choose modifiers depending on conditions (such as if, switch, etc.).

```swift
Image(systemName: tab.symbolImage)
    .font(.title2)
    .symbolVariant(.fill)
    .modifiers { content in
        switch tab {
        case .home: content
                .symbolEffect(.bounce.byLayer.down, value: activeTab == tab)
        case .search: content
                .symbolEffect(.wiggle.counterClockwise, value: activeTab == tab)
        case .settings: content
                .symbolEffect(.rotate.byLayer, value: activeTab == tab)
        }
    }
```

The value of the symbolEffect triggers the animation whenever it's changed, so when a tab is changed from one to anoter, both symbol effect modifier values get changed, and results in animating both old and new Icons. Let's solve this issue by introducing a dedicated state value for doing symbol effects.

```swift
@State private var symbolEffectTrigger: TabValue?

TabView(selection: .init(get: {
    activeTab
}, set: { newValue in
    activeTab = newValue
    symbolEffectTrigger = newValue
    var transaction = Transaction()
    transaction.disablesAnimations = true
    withTransaction(transaction) {
        symbolEffectTrigger = nil
    }
})) {
    ...
}
```

So what this will do is when ever the tab gets clicked, it will animate the icon with a symbol effect, and the next change won't be animated since we explicityl disabled animation for that action.
Thus animating the currently tapped icon only once.

```swift
switch tab {
case .home: content
        .symbolEffect(.bounce.byLayer.down, options: .speed(1.2), value: symbolEffectTrigger == tab)
case .search: content
        .symbolEffect(.wiggle.counterClockwise, options: .speed(1.4), value: symbolEffectTrigger == tab)
case .settings: content
        .symbolEffect(.rotate.byLayer, options: .speed(2), value: symbolEffectTrigger == tab)
}
```

We still didn't address one of it's main issues: when the tabbar is hidden from the tab view using the toolBarVisibility modifier, those customized icons will be still visible. Let me show you an example.

```swift
@State private var hiddenTabbar: Bool = false

...
DummyScrollView()
    .overlay(alignment: .topTrailing) {
        Button("Hidden TabBar") {
            hiddenTabbar.toggle()
        }
        .foregroundStyle(.white)
        .padding(25)
    }
    .toolbarVisibility(tabbarData.hiddenTabbar ? .hidden : .visible, for: .tabBar)
```

This can be simply resolevd using two ways:

1.By taking advantage of SceneStorge Wrapper.

Since SceneStorge will work in any view, you can update the tabbar visibility from any where

```swift
@SceneStorage("hideTabBar") private var hiddenTabbar: Bool = false

...
AnimatedTabBar()
    .opacity(hiddenTabbar ? 0 : 1)
...

```

SceneStorage is now working on previews, thus using Simulator.

2.Sometimes we don't want those state restoration features, or sometimes we want to update the tab bar visible status outside of the view's scope, such as Model, View Model, etc. For those instances, we can see @Observable to create a class that can be shared across all the tab child views and use it to update the tab bar visibility.

```swift
@Observable
class TabarData {
    var hiddenTabbar: Bool = false
}

...

/// Type: 1
// @SceneStorage("hideTabBar") private var hiddenTabbar: Bool = false
/// Type: 2

var tabbarData = TabarData()

...
    Button("Hidden TabBar") {
        tabbarData.hiddenTabbar.toggle()
    }
...

.toolbarVisibility(tabbarData.hiddenTabbar ? .hidden : .visible, for: .tabBar)

...

.environment(tabbarData)

...
AnimatedTabBar()
    .opacity(tabbarData.hiddenTabbar ? 0 : 1)
...

```

There is one last thing we need to do, since the customed icons added as an overlay to the tab view, it will move around when a keyboard becomes active.
To solve this, simply use the .ignoreSafeArea(.keyboard) modifier.

```swift
...

/// Hidden Dummy Scroll View
// DummyScrollView()

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
    
...

.overlay(alignment: .bottom) {
    ...
}
.ignoresSafeArea(.keyboard, edges: .all)

```

For more videos, like this, please do like and subscribe to the channel.
Have a great day, Folks!
