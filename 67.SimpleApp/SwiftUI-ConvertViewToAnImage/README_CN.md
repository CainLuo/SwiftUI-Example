#  将 SwiftUI 视图转换为图像

有时，在某些地方需要对视图进行快照。在 SwiftUI 中，我们有 ImageRenderer 来实现这一功能，但它有很多限制，例如它无法拍摄滚动视图、列表等的快照。

```swift
extension View {
    @ViewBuilder
    func snapshot(trigger: Bool, onComplete: @escaping (UIImage) -> ()) -> some View {
        self
            .modifier(SnapshotModifier(trigger: trigger, onComplete: onComplete))
    }
}

fileprivate struct SnapshotModifier: ViewModifier {
    var trigger: Bool
    var onComplete: (UIImage) -> ()

    /// Local View Modifier Properties
    @State private var view: UIView = .init(frame: .zero)

    func body(content: Content) -> some View {
        if #available(iOS 17, *) {
            content
                .background(ViewExtractor(view: view))
                .onChange(of: trigger) { oldValue, newValue in
                    generateSnapshot()
                }
        } else {
            content
                .background(ViewExtractor(view: view))
                .onChange(of: trigger) { newValue in
                    generateSnapshot()
                }
        }
    }

    private func generateSnapshot() {
        if let superView = view.superview?.superview {
            print(superView)
        }
    }
}

fileprivate struct ViewExtractor: UIViewRepresentable {
    var view: UIView
    
    func makeUIView(context: Context) -> UIView {
        view.backgroundColor = .clear
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
```

```swift
struct ContentView: View {
    @State private var trigger: Bool = false
    
    var body: some View {
        VStack(spacing: 25) {
            Button("Take Snaapshot") {
                
            }
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .snapshot(trigger: trigger) {
                snapshot = $0
            }
            
            if let snapshot {
                Image(uiImage: snapshot)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 10)
            }
        }
    }
}
```

之所以要附加一个虚拟 UIView 作为背景，是因为它允许我们遍历并找到 SwiftUI 视图对应的 UIView。

```swift
#Preview {
    ContentView()
}
```

正如你所看到的，当使用超级视图属性进行遍历时，它只是直达根视图，而不是所需的视图。为了解决这个问题，我们可以使用 compostingGroup 修改器。

```swift
...
if #available(iOS 17, *) {
    content
        .background(ViewExtractor(view: view))
        .compositingGroup()
        .onChange(of: trigger) { oldValue, newValue in
            generateSnapshot()
        }
} else {
    content
        .background(ViewExtractor(view: view))
        .compositingGroup()
        .onChange(of: trigger) { newValue in
            generateSnapshot()
        }
}
...
```

> Note: compositingGroup
> Grouped View
>      * Current SwiftUI View
>      * Background UIView
> When we use the compositingGroup modifier, it just wraps all of the views into a single one, and we can access this grouped view by traversing over it using the superview property. Once we find it, we can use it to take snapshots.

> Note: compositingGroup
> 分组视图
> * 当前 SwiftUI 视图
> * 背景 UIView
> 当我们使用 compositingGroup 修饰符时，它只是将所有视图封装成一个单一视图，我们可以通过使用 superview 属性遍历该视图来访问这个分组视图。一旦找到它，我们就可以用它来拍摄快照。


```const
<SwiftUI._UIInheritedView: 0x101430430; frame = (137.667 107.333; 126.667 78); anchorPoint = (0, 0); autoresizesSubviews = NO; layer = <CALayer: 0x600000282f00>>
```

现在我们找到了合适的 UIView，可以将其与 UIGraphicsImageRenderer 结合使用来创建快照图像。

更新 generateSnapshot() 方法：

```swift
private func generateSnapshot() {
    if let superView = view.superview?.superview {
        let renderer = UIGraphicsImageRenderer(size: superView.bounds.size)
        let image = renderer.image { _ in
            superView.drawHierarchy(in: superView.bounds, afterScreenUpdates: true)
        }
        onComplete(image)
    }
}
```

更新 ContentView 主体代码：

```swift
VStack(spacing: 25) {
    Button("Take Snaapshot") {
        
    }
    
    VStack {
        Image(systemName: "globe")
            .imageScale(.large)
        Text("Hello, world!")
    }
    .foregroundStyle(.white)
    .padding()
    .background(.red.gradient, in: .rect(cornerRadius: 15))
    .snapshot(trigger: trigger) {
        snapshot = $0
    }
    
    if let snapshot {
        Image(uiImage: snapshot)
            .aspectRatio(contentMode: .fit)
    }
}
```

它不仅限于常规视图，还可以附加到列表、滚动视图、导航堆栈等任何视图中。让我举例说明导航堆栈与列表视图的用法。

```swift
NavigationStack {
    VStack {
        List {
            ForEach(1...20, id: \.self) { index in
                Text("List Cell \(index)")
            }
        }
    }
    .snapshot(trigger: trigger) {
        snapshot = $0
    }
    .navigationTitle("List View")
    .toolbar {
        ToolbarItem {
            Button("Snapshot") {
                trigger.toggle()
            }
        }
    }
}
.overlay {
    if let snapshot {
        Image(uiImage: snapshot)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(.rect(cornerRadius: 10))
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Rectangle()
                    .fill(.black.opacity(0.3))
                    .ignoresSafeArea()
                    .onTapGesture {
                        self.snapshot = nil
                    }
            }
    }
}
```

我将快照修改器附加到了 List 而不是 NavigationStack，因此它创建了 ListView 的快照。
现在，让我们将修改器从 list 改为整个导航栈。

```swift
NavigationStack {
    VStack {
        List {
            ForEach(1...20, id: \.self) { index in
                Text("List Cell \(index)")
            }
        }
    }
    .navigationTitle("List View")
    .toolbar {
        ToolbarItem {
            Button("Snapshot") {
                trigger.toggle()
            }
        }
    }
    .snapshot(trigger: trigger) {
        snapshot = $0
    }
}
.overlay {
    if let snapshot {
        Image(uiImage: snapshot)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(.rect(cornerRadius: 10))
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Rectangle()
                    .fill(.black.opacity(0.3))
                    .ignoresSafeArea()
                    .onTapGesture {
                        self.snapshot = nil
                    }
            }
    }
}
```

> 注意：
> 如果您还想在快照中包含安全区域，只需在快照修改器后使用 ignoreSafeArea 修改器即可。

```swift

...
.ignoresSafeArea()
.overlay {
    if let snapshot {

...

```
