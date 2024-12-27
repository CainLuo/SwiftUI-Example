//
//  Toasts.swift
//  SwiftUI-Toasts
//
//  Created by Cain on 2024/11/18.
//

import SwiftUI

struct Toast: Identifiable {
    private(set) var id: String = UUID().uuidString
    var content: AnyView
    
    init(@ViewBuilder content: @escaping (String) -> some View) {
        /// 1.This ID can be used to remove toast from the context
        self.content = .init(content(id))
    }

    /// View Properties
    var offsetX: CGFloat = 0
    var isDeleting: Bool = false
}

extension View {
    @ViewBuilder
    func interactiveToasts(_ toasts: Binding<[Toast]>) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom) {
                ToastsView(toasts: toasts)
            }
    }
}

fileprivate struct ToastsView: View {
    @Binding var toasts: [Toast]
    /// View Properties
    /// 4.The toasts will get switched from ZStack to VStack when it's tapped, for that purpose, we can use this state property.
    @State private var isExpanded: Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            if isExpanded {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isExpanded = false
                    }
            }
            
            /// 5.AnyLayout will seamlessly update its layout and items with animations.
            let layout = isExpanded ? AnyLayout(VStackLayout(spacing: 10)) : AnyLayout(ZStackLayout())
            
            layout {
                ForEach($toasts) { $toast in
//                    let index = (toasts.firstIndex(where: { $0.id == toast.id }) ?? 0)
                    /// 8.We can simply reverse the index to make it as a stacked cards.
                    let index = (toasts.count - 1) - (toasts.firstIndex(where: { $0.id == toast.id }) ?? 0)
                    
                    /// 10.Now, you can understand how just one simple code changed the entire view perspective.
//                    let index = (toasts.firstIndex(where: { $0.id == toast.id }) ?? 0)

                    toast.content
                        .offset(x: toast.offsetX)
                    /// 6.Now, let's make it as a stack with the help of the visualEffect modifier.
//                        .visualEffect { [isExpanded] content, proxy in
//                            content
//                                /// 9.Now, let's apply some scaling effect.
//                                .scaleEffect(isExpanded ? 1 : scale(index), anchor: .bottom)
//                                .offset(y: isExpanded ? 0 : offsetY(index))
//                        }
//                        .transition(.asymmetric(insertion: .offset(y: 100), removal: .push(from: .top)))
//                        .transition(.asymmetric(insertion: .offset(y: 100), removal: .move(edge: .leading)))
                    /// 11.Now, let's integrate the gesture interactivity into the toast.
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let xOffset = value.translation.width < 0 ?
                                    value.translation.width : 0
                                    toast.offsetX = xOffset
                                }
                                .onEnded { value in
                                    let xOffset = value.translation.width + (value.velocity.width / 2)
                                    
                                    if -xOffset > 200 {
                                        /// Remove Toast
                                        /// 13.Since the extension is a binding one, make sure you use the "$" symbol to access it.
                                        /// 14.As you can see, there are two problems we need to address, One is to change it's removal transition to a move-based one, and the second is that when the toast is being removed, it's being pushed back to the stack. To solve this, we can use ZIndex to increase its value when it's being removed.
                                        $toasts.delete(toast.id)
                                    } else {
                                        /// Reset Toast to it's initial Position
                                        toast.offsetX = 0
                                        
                                        /// Note: Wrap this with the "withAnimation" modifier to have animations when it's resetting to its initial position.
                                    }
                                }
                        )
                        .visualEffect { [isExpanded] content, proxy in
                            content
                            /// 9.Now, let's apply some scaling effect.
                                .scaleEffect(isExpanded ? 1 : scale(index), anchor: .bottom)
                                .offset(y: isExpanded ? 0 : offsetY(index))
                        }
                        .zIndex(toast.isDeleting ? 1000 : 0)
                    /// 18. So this will make the toast view occupy the full available width, making the transition removal work fine.
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .offset(y: 100), removal: .move(edge: .leading)))
                }
            }
            .onTapGesture {
                isExpanded.toggle()
            }
            .padding(.bottom, 15)
        }
        .animation(.bouncy, value: isExpanded)
        /// 15.Let's change it's expansion state when there is no toast being present.
        /// 16.We're almost complete, but there is one more little issue still here. Let me show it to you.
        .onChange(of: toasts.isEmpty) { oldValue, newValue in
            if newValue {
                isExpanded = false
            }
        }
    }
    
    /// 7.I just want to show only two extra cards, that's why I limited the value to 30. If you want more cards to be visible, then adjust this value as per your needs.
    nonisolated func offsetY(_ index: Int) -> CGFloat {
        let offset = min(CGFloat(index) * 15, 30)
        
        return -offset
    }

    nonisolated func scale(_ index: Int) -> CGFloat {
        let scale = min(CGFloat(index) * 0.1, 1)
        
        return 1 - scale
    }
}

/// 12.This little extension will be useful to remove toasts based on their ID, and since I'm making changes to the binding value rather than the struct, the animation will be still active. (If you make changed to struct, then there will be no animations present.)
extension Binding<[Toast]> {
    func delete(_ id: String) {
        if let toast = first(where: { $0.id == id }) {
            toast.wrappedValue.isDeleting = true
        }
        
        withAnimation(.bouncy) {
            self.wrappedValue.removeAll(where: { $0.id == id })
        }
    }
}

#Preview {
    ContentView()
}
