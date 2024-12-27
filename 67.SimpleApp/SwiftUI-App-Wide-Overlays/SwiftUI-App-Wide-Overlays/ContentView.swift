//
//  ContentView.swift
//  SwiftUI-App-Wide-Overlays
//
//  Created by Cain on 2024/10/28.
//

import AVKit
import SwiftUI

struct ContentView: View {
    @State private var show: Bool = false
    @State private var showSheet: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Button("Floating Video Player") {
                    show.toggle()
                }
                .unversalOverlay(show: $show) {
                    // It will add the view on top the entire SwiftUI App, so you can use it anywhere in your code.
                    FloatingVideoPlayerView(show: $show)
                }
                
                Button("Show Dummy Sheet") {
                    showSheet.toggle()
                }
            }
            .navigationTitle("Universal Overlay")
        }
        .sheet(isPresented: $showSheet) {
            /// It's all wroking well, but let me show you ont thing, which must be noted when using the unversal overlay modifier.
            Text("Hello From Sheets!")
        }
    }
}

/// And that's it. We successfully created a universal overlay modifier that will add the view on top of the entire SwiftUI app.
/// Now let me show you how you can create a floating video player, which you've seen in the intro video, with the help of this modifier.
struct FloatingVideoPlayerView: View {
    @Binding var show: Bool
    /// View Properties
    @State private var player: AVPlayer?
    @State private var offset: CGSize = .zero
    @State private var lastStoredOffset: CGSize = .zero
    var body: some View {
        GeometryReader {
            let size = $0.size
            Group {
                if videoURL != nil {
                    VideoPlayer(player: player)
                        .background(.black)
                        .clipShape(.rect(cornerRadius: 25))
                } else {
                    RoundedRectangle(cornerRadius: 25)
                }
            }
            .frame(height: 250)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let translation = value.translation + lastStoredOffset
                        offset = translation
                    }
                    .onEnded { value in
                        /// For me, Xcode 16 had the most unstable previews than its previous versions. Thus, let me use the simulator to show the demo.
                        withAnimation(.bouncy) {
                            /// Limiting to not move away from the screen
                            offset.width = 0
                            
                            if offset.height < 0 {
                                offset.height = 0
                            }
                            
                            if offset.height > (size.height - 250) {
                                offset.height = (size.height - 250)
                            }
                        }
                        lastStoredOffset = offset
                    }
            )
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .padding(.horizontal, 15)
        .transition(.blurReplace)
        .onAppear {
            if let videoURL {
                player = AVPlayer(url: videoURL)
                player?.play()
            }
        }
    }
    
    var videoURL: URL? {
        if let bundle = Bundle.main.path(forResource: "Area", ofType: "mp4") {
            return .init(filePath: bundle)
        }
        return nil
    }
}

extension CGSize {
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        .init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

#Preview {
    /// As I said earlier, if you want previews to be working, you must wrap your preview view with the RootView wrapper.
    RootView {
        ContentView()
    }
}
