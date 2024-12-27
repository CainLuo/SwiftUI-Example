//
//  ExpandableMusicPlayer.swift
//  SwiftUI-AppleMusicBottomSheet
//
//  Created by Cain on 2024/10/29.
//

import SwiftUI

struct ExpandableMusicPlayer: View {
    @Binding var show: Bool
    /// View Properties
    @State private var expandPlayer: Bool = false
    @State private var offsetY: CGFloat = 0
    @State private var mainWindow: UIWindow?
    @State private var windowProgress: CGFloat = 0
    /// Let's make this even bettter by adding matched GeometryEffect to the artwork image view.
    @Namespace var animation
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            if #available(iOS 18.0, *) {
                ZStack(alignment: .top) {
                    /// Background
                    ZStack {
                        Rectangle()
                        /// I've generated these colors based on the artwork image. Optionally, you can write your own extension to find the most widely used colors in the image, but for this video, I'm going to use these as background.
                            .fill(.white)
                        
                        Rectangle()
                            .fill(.linearGradient(colors: [.primary, .purple, .blue], startPoint: .top, endPoint: .bottom))
                            .opacity(expandPlayer ? 1 : 0)
                    }
                    /// You can customize this corner radius value based on devices, but for the video purpose, I'm going with this default value.
                    .clipShape(.rect(cornerRadius: expandPlayer ? 45 : 15))
                    .frame(height: expandPlayer ? nil : 55)
                    /// Shadows
                    .shadow(color: .primary.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: .primary.opacity(0.05), radius: 5, x: -5, y: -5)
                    
                    /// That's it, we successfully created a mini player just like the Apple Music app, but what if you wanted the background scaling effect just like the Apple Music app? It kind of works like a full-sheet. Well, let's implement that effect as well.
                    MiniPlayer()
                        .opacity(expandPlayer ? 0 : 1)
                    
                    ExpandedPlayer(size, safeArea)
                        .opacity(expandPlayer ? 1 : 0)
                }
                /// Limiting the height based on the expandPlayer state value
                .frame(height: expandPlayer ? nil : 55, alignment: .top)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, expandPlayer ? 0 : safeArea.bottom + 55)
                .padding(.horizontal, expandPlayer ? 0 : 15)
                .offset(y: offsetY)
                .gesture(
                    /// Update: Add.
                    /// guard expandPlayer else { return }
                    /// At the start of both onChange and onEnd handlers.
                    PanGesture { value in
                        let translation = max(value.translation.height, 0)
                        offsetY = translation
                        windowProgress = max(min(translation / size.height, 1), 0) * 0.1
                        resizeWindow(0.1 - windowProgress)
                    } onEnd: { value in
                        let translation = max(value.translation.height, 0)
                        let velocity = value.velocity.height / 5

                        withAnimation(.smooth(duration: 0.3, extraBounce: 0)) {
                            if (translation + velocity) > (size.height * 0.5) {
                                /// Closing View
                                expandPlayer = false
                                /// Resetting Window To Identity With Animation
                                resetWindowWithAnimation()
                            } else {
                                /// Reset Window To 0.1 With Animation
                                UIView.animate(withDuration: 0.3) {
                                    resizeWindow(0.1)
                                }
                            }
                            offsetY = 0
                        }
                    }
                )
                .ignoresSafeArea()
            } else {
                // Fallback on earlier versions
            }
        }
        .onAppear {
            if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow, mainWindow == nil {
                mainWindow = window
            }
        }
    }
    
    /// Mini Player
    /// As you can see, we successfully created a floating mini player, and when it's tapped, it's getting expanded just like the Apple Music app. Now let's implement the expanded player view.
    @ViewBuilder
    func MiniPlayer() -> some View {
        HStack(spacing: 12) {
            ZStack {
                if !expandPlayer {
                    Image("Music")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(.rect(cornerRadius: 10))
                        .matchedGeometryEffect(id: "Artwork", in: animation)
                }
            }
            .frame(width: 45, height: 45)
            
            Text("Calm Down")
            
            Spacer(minLength: 0)
            
            Group {
                Button("", systemImage: "play.fill") {
                    
                }
                
                Button("", systemImage: "forward.fill") {
                    
                }
            }
            .font(.title3)
            .foregroundColor(Color.primary)
        }
        .padding(.horizontal, 10)
        .frame(height: 55)
        .contentShape(.rect)
        .onTapGesture {
            withAnimation(.smooth(duration: 3, extraBounce: 0)) {
                expandPlayer = true
            }
            
            /// Reszing Window When Opening Player
            UIView.animate(withDuration: 0.3) {
                resizeWindow(0.1)
            }
        }
    }
    
    @ViewBuilder
    func ExpandedPlayer(_ size: CGSize, _ safeArea: EdgeInsets) -> some View {
        VStack(spacing: 12) {
            Capsule()
                .fill(.white.secondary)
                .frame(width: 35, height: 5)
                .offset(y: -10)
            
            /// Sample Player View
            /// Simple Expanded Player view just like the Apple Music app.
            HStack(spacing: 12) {
                ZStack {
                    if expandPlayer {
                        Image("Music")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(width: 80, height: 80)
                            .matchedGeometryEffect(id: "Artwork", in: animation)
                            .transition(.offset(y: 1))
                    }
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Calm Down")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)

                    Text("Rema, Selena Gemoz")
                        .font(.caption2)
                        .foregroundStyle(.white.secondary)
                }
                
                Spacer(minLength: 0)
                
                HStack(spacing: 0) {
                    Button("", systemImage: "star.circle.fill") {
                        
                    }
                    Button("", systemImage: "ellipsis.circle.fill") {
                        
                    }
                }
                .foregroundStyle(.white, .white.tertiary)
                .font(.title2)
            }
        }
        .padding(15)
        .padding(.top, safeArea.top)
    }
    
    func resizeWindow(_ progress: CGFloat) {
        /// The first subview of the key window is our SwiftUI app content, and all the other subviews are sheets/fullscreencovers/inspector, etc.
        /// And since the max window progress value is 0.1 and the maximum scaling that will be applied will be 0.9, let's see how it looks by creating a slider to stimulate the effect.
        if let mainWindow {
            let offsetY = (mainWindow.frame.height * progress) / 2
            
            /// Your Custom Corner Radius
            mainWindow.layer.cornerRadius = (progress / 0.1) * 30
            
            /// Now, let's intergrate this with our Expandable Player View.
            mainWindow.layer.masksToBounds = true
            
            mainWindow.subviews.first?.transform = .identity.scaledBy(x: 1 - progress, y: offsetY)
        }
    }
    
    func resetWindowWithAnimation() {
        if let mainWindow = mainWindow?.subviews.first {
            UIView.animate(withDuration: 0.3) {
                mainWindow.layer.cornerRadius = 0
                mainWindow.transform = .identity
            }
        }
    }
}

#Preview {
    RootView {
        Home()
    }
}
