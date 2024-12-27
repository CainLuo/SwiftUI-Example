#  Convert a SwiftUI view to an image

Sometimes taking snapashots of the view is necessary in some areas. In SwiftUI, we have ImageRenderer to do that, but it has lots of limitations, such as that it won't take snapshots of scrollviews, lists, etc.

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

The reason for attaching a dummy UIView as a background is that it allows us to traverse through and find the corresponding UIView for the SwiftUI View.

```swift
#Preview {
    ContentView()
}
```

As you can see when traversing using the superview property, it just wnet straight up to the root view and not the desired view. To solve this, we can use the compostingGroup modifier.

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

```const
<SwiftUI._UIInheritedView: 0x101430430; frame = (137.667 107.333; 126.667 78); anchorPoint = (0, 0); autoresizesSubviews = NO; layer = <CALayer: 0x600000282f00>>
```

Now that we found the appropriate UIView, we can use this with UIGraphicsImageRenderer to create a snapshot image.

update generateSnapshot() method:

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

update ContentView body code:

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

It's not limited to regular views, You can attach this to any views such as lists, scrollviews, navigation stacks, etc. Let me show and example usage with navigation stack with a list view.

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

I attached the snapshot modifier to the List and not NavigationStack, thus it creates a snapshot of the ListView.
Now, let's change the modifier from list to the whole navigation stack.

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

> NOTE:
> If you also want to include safeAreas in your snapshot, just use the ignoreSafeArea modifier after the snapshot modifier.

```swift

...
.ignoresSafeArea()
.overlay {
    if let snapshot {

...

```
