# 微交互标签栏

我们的应用程序中通常会有这样一个标签栏，默认情况下，SwiftUI 标签按钮是无法自定义的，因为它是默认的，创建一个自定义的标签按钮就可以使用所有原生功能（如点击标签按钮滚动到顶部和其余导航链接，仅在 iOS 18+ 版本中可用），所以在本视频中，让我们来看看如何在不破坏任何默认功能的情况下自定义标签按钮。

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

这样做只会移除标签栏上的标签，标签栏及其操作仍将存在，通过这样做，我们可以在标签栏上叠加自定义的标签按钮。

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

我们只想通过自定义来显示我们的标签，而不想中断底层标签栏的操作，因此我明确禁用了它的用户交互功能。

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

这是默认系统使用的最理想的标签栏高度。

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

添加 Dumy 滚动视图：

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

更新 Tab home case 的代码：

```swift
Tab(value: .home) {
    DummyScrollView()
}
```

现在，我向大家展示了如何在不影响默认行为的情况下自定义标签栏标签。现在，让我们为每个选项卡图标添加一些可爱的符号效果（每个选项卡图标将有不同的符号效果）。

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

这个小小的简单自定义修改器允许我根据条件（如如果、开关等）选择修改器。

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

每当 symbolEffect 的值发生变化时就会触发动画，因此当一个标签从一个变为另一个时，两个符号效果修改器的值都会发生变化，从而导致新旧图标都发生动画。让我们为符号效果引入一个专用的状态值来解决这个问题。

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

因此，这样做的目的是，当标签被点击时，它将用符号效果为图标制作动画，而下一次更改将不会制作动画，因为我们已经禁用了该操作的动画效果。
这样，当前点击的图标就只会有一次动画效果。

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

我们仍然没有解决它的一个主要问题：当使用 toolBarVisibility 修改器从标签视图中隐藏标签栏时，这些自定义图标仍然可见。让我举个例子。

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

这可以通过两种方法简单地实现：

1.利用 SceneStorge Wrapper。

由于 SceneStorge 可在任何视图中运行，因此您可以在任何位置更新标签栏的可见性。

```swift
@SceneStorage("hideTabBar") private var hiddenTabbar: Bool = false

...
AnimatedTabBar()
    .opacity(hiddenTabbar ? 0 : 1)
...

```

SceneStorage 现在可以在预览中工作，因此可以使用模拟器。

2.有时我们不需要这些状态恢复功能，或者有时我们想在视图的作用域（如模型、视图模型等）之外更新选项卡栏的可见状态。对于这些情况，我们可以使用 @Observable 来创建一个可以在所有选项卡子视图中共享的类，并使用它来更新选项卡栏的可见性。

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

我们还需要做最后一件事，因为自定义图标是作为覆盖层添加到标签视图中的，所以当键盘处于活动状态时它会左右移动。

要解决这个问题，只需使用 .ignoreSafeArea(.keyboard) 修改器即可。

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

如需观看更多类似视频，请点赞并订阅本频道。

祝您有美好的一天，朋友们！
