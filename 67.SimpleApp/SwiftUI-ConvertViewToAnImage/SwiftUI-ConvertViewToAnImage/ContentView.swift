//
//  ContentView.swift
//  SwiftUI-ConvertViewToAnImage
//
//  Created by Cain on 2024/11/1.
//

/// Sometimes taking snapashots of the view is necessary in some areas. In SwiftUI, we have ImageRenderer to do that, but it has lots of limitations, such as that it won't take snapshots of scrollviews, lists, etc.
/// So today in this video, let's see how we can create a new custom modifier that will easily take a snapshot of the attached view instantly.

import SwiftUI

struct ContentView: View {
    @State private var trigger: Bool = false
    @State private var snapshot: UIImage?
    var body: some View {
//        VStack(spacing: 25) {
//            Button("Take Snaapshot") {
//                
//            }
//            
//            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                Text("Hello, world!")
//            }
//            .foregroundStyle(.white)
//            .padding()
//            .background(.red.gradient, in: .rect(cornerRadius: 15))
//            .snapshot(trigger: trigger) {
//                snapshot = $0
//            }
//            
//            if let snapshot {
//                Image(uiImage: snapshot)
//                    .aspectRatio(contentMode: .fit)
//            }
//        }

        /// I attached the snapshot modifier to the List and not NavigationStack, thus it creates a snapshot of the ListView.
        /// Now, let's change the modifier from list to the whole navigation stack.
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
        }
        .snapshot(trigger: trigger) {
            /// NOTE:
            /// If you also want to include safeAreas in your snapshot, just use the ignoreSafeArea modifier after the snapshot modifier.
            snapshot = $0
        }
        .ignoresSafeArea()
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
    }
}

//#Preview {
//    ContentView()
//}
