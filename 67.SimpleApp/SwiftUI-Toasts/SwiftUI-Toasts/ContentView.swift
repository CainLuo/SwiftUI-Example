//
//  ContentView.swift
//  SwiftUI-Toasts
//
//  Created by Cain on 2024/11/18.
//

import SwiftUI

struct ContentView: View {
    @State private var toasts: [Toast] = []
    
    var body: some View {
        NavigationStack {
            List {
                Text("Dummy List Row View")
            }
            .navigationTitle("Toasts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Show", action: showToast)
                }
            }
        }
        /// 2.Place this modifier at the end of the view. If you're in sheet's/fullScreenCover, then place it inside of it as it's based on it's current context and not universal.
        .interactiveToasts($toasts)
    }

    func showToast() {
        withAnimation(.bouncy) {
            let toast = Toast { id in
                ToastView(id)
            }
            toasts.append(toast)
        }
    }
    
    /// YOUR CUSTOM TOAST VIEW
    /// 3.This is just a simple toast view. Since the toast adapts the AnyView protocol, you can create whatever view you need to be presented in the toast.
    /// NOTE: Do not overweight the toast views.
    @ViewBuilder
    func ToastView(_ id: String) -> some View {
        HStack(spacing: 12) {
            /// 17.When we pass a smaller view than it's actual view width, the removal animation will not completely remove the toast from the screen, and another one l've noticed is that applying the offset modifier after the transition modifier makes some animation glitched, so we can apply it at the end of the toast view.
            Image(systemName: "airpods.pro")
            
            Text("Cain Luo's Airpods")
                .font(.callout)
            
//            Spacer(minLength: 0)
//            
//            Button {
//                $toasts.delete(id)
//            } label: {
//                Image(systemName: "xmark.circle.fill")
//                    .font(.title2)
//            }
        }
        .foregroundStyle(Color.primary)
        .padding(.vertical, 12)
        .padding(.horizontal, 15)
//        .padding(.trailing, 10)
        .background {
            Capsule()
                .fill(.background)
                /// Shadows
                .shadow(color: .black.opacity(0.06), radius: 3, x: -1, y: -3)
                .shadow(color: .black.opacity(0.06), radius: 2, x: 1, y: 3)
        }
//        .padding(.horizontal, 15)
    }
}

#Preview {
    ContentView()
}
