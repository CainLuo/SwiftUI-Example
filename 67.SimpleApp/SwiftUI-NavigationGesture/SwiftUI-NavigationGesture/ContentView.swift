//
//  ContentView.swift
//  SwiftUI-NavigationGesture
//
//  Created by Cain on 2024/11/28.
//

import SwiftUI

@Observable
class NavigationHelper: NSObject, UIGestureRecognizerDelegate {
    var path: NavigationPath = .init()
    var popProgress: CGFloat = 1.0
    /// Properties
    private var isAdded: Bool = false
    private var navController: UINavigationController?
    
    func addPopGestureListener(_ controller: UINavigationController) {
        guard !isAdded else { return }
        controller.interactivePopGestureRecognizer?.addTarget(self, action: #selector(didInteractivePopGestureChange))
        navController = controller
        /// Optional
        controller.interactivePopGestureRecognizer?.delegate = self
        isAdded = true
    }
    
    /// 7.Now that we've successfully retrieved the pop progress from the navigation controller, let's use it to fade in and out the controls.
    @objc
    func didInteractivePopGestureChange() {
        if let completionProgress = navController?.transitionCoordinator?.percentComplete,
           let state = navController?.interactivePopGestureRecognizer?.state,
           /// 9.Using the path here won't work because it's a UIKit callback. That's why I'm directly using the navigation controller to check the count.
           navController?.viewControllers.count == 1 {
            popProgress = completionProgress
            
            if state == .ended || state == .cancelled {
                if completionProgress > 0.5 {
                    /// Popped
                    popProgress = 1
                } else {
                    /// Reset
                    popProgress = 0
                }
            }
        }
    }
    
    /// This will make interactive pop gesture to work even when navigation bar is hidden
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        navController?.viewControllers.count ?? 0 > 1
    }
}

struct ContentView: View {
    var navigationHelper: NavigationHelper = .init()
    var body: some View {
        VStack(spacing: 0) {
            @Bindable var bindableHelper = navigationHelper
            NavigationStack(path: $bindableHelper.path) {
                List {
                    Button {
                        navigationHelper.path.append("iJustine")
                    } label: {
                        Text("iJustine's Post")
                            .foregroundStyle(Color.primary)
                    }
                    
                    /// 6.Apply this directly to the view you want to extract. Don't apply it after some modifiers. Otherwise, the result will return the modifier instead of the actual view.
//                    Slider(value: .constant(0))
//                        .viewExtractor { view in
//                            if let textFiled = view as? UISlider {
//                                print(textFiled)
//                            }
//                        }
                }
                .navigationTitle("Home")
                .navigationDestination(for: String.self) { navTitle in
                    //                    Text("Post's View")
                    List {
                        /// 8.We want the controls to fade in and out only for the root view, not for every navigation view. Let's fix this issue.
                        Button {
                            navigationHelper.path.append("More Post's")
                        } label: {
                            Text("More iJustine's Post")
                                .foregroundStyle(Color.primary)
                        }
                    }
                    .navigationTitle(navTitle)
                    /// 10.Let me present another possibility that cannot be achieved with the current SwiftUI navigation stack, which is enabling the pop gesture for navigation bar hidden views.
                    .toolbarVisibility(.hidden, for: .navigationBar)
                }
                /// 2.Now, let's utilize the navigation path to display different controls in the tab bar, when it's not the root view.
            }
            .viewExtractor {
                if let navController = $0.next as? UINavigationController {
                    navigationHelper.addPopGestureListener(navController)
                }
            }
            
            CustomBottomBar()
        }
        .environment(navigationHelper)
    }
}

#Preview {
    ContentView()
}
