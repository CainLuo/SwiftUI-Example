//
//  ContentView.swift
//  SwiftUI-ExtractView
//
//  Created by Cain on 2024/12/2.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            /// Some view's are native SwiftUI View's which don't contain any UIKit view
//            Text("Hello, world!")
//                .viewExtractor { view in
//                    print(view)
//                    
//                    Text("View: \(view)")
//                }
            
            /// Some are a UIKit view's wrapped up with SwiftUI Wraooerm TextFuekdm Skuderm Kust etc.
            /// EG: 1
            TextField("Hello World", text: .constant(""))
                .viewExtractor { view in
                    if let textFiled = view as? UITextField {
                        print(textFiled)
                    }
                }
            
            /// EG: 2
            Slider(value: .constant(0.2))
                .viewExtractor { view in
                    if let slider = view as? UISlider {
                        print(slider)

                        slider.tintColor = .red
                        slider.thumbTintColor = .systemBlue
                    }
                }
            
            /// EG: 3
            List {
                Text("Hello World")
            }
            .viewExtractor { view in
                if let list = view as? UICollectionView {
                    print(list)
                }
            }
            
            /// EG: 4
            ScrollView {
                Text("Hello World")
            }
            .viewExtractor { view in
                if let scrollview = view as? UIScrollView {
                    print(scrollview)
                }
            }
            
            /// EG: 5, Finally Some are UIViewControllers, NavigationStack, TabView etc,
            /// for Those we can use next Property to extract those controllers
            NavigationStack {
                List {
                    
                }
                .navigationTitle("Home")
            }
            .viewExtractor { view in
                if let navController = view.next as? UINavigationController {
                    print(navController)
                }
            }
            
            /// EG: 6
            TabView {
                Text("123")
            }
            .viewExtractor { view in
                if let tabController = view.next as? UITabBarController {
                    print(tabController)
                    
                    tabController.tabBar.isHidden = true
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

/// 1.How this works?
/// When using a Composite group in SwiftUI, the background view and the given SwiftUI view are combine into a single Wrapped UIView. We first extract this wrapped view using the superview property. Since the extractor is applied as the background, the SwiftUI view is the last subview, and each UIKit view is wrapped into a SwiftUI hosting view. Therefore, the subview of the SwiftUI view must contain the required UIKit view. For a better understranding, refer to the attached image.
/// Grouped View (superview.superview)
/// - Extractor View(Background)
/// - SwiftUI View(subviews.last)
/// - Hosting Kind a View
/// - UIKit View(subviews.first)
/// Some views are native SwiftUI views and don't contain any UIKit views. In such cases, the view will be null because there's no UIKit view present at all.
extension View {
    @ViewBuilder
    func viewExtractor(result: @escaping (UIView) -> ()) -> some View {
        self
            .background(ViewExtractHelper(result: result))
            .compositingGroup()
    }
}

fileprivate struct ViewExtractHelper: UIViewRepresentable {
    var result: (UIView) -> ()
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            if let uiKitView = view.superview?.superview?.subviews.last?.subviews.first {
                result(uiKitView)
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
