//
//  DisintegrationEffect.swift
//  SwiftUI-DisintegrationEffect
//
//  Created by Cain on 2024/11/22.
//

import SwiftUI

extension View {
    @ViewBuilder
    func disintegrationEffect(isDeleted: Bool, completion: @escaping () -> ()) -> some View {
        self
            .modifier(DisintegrationEffectModifier(isDeleted: isDeleted, completion: completion))
    }
}

fileprivate struct DisintegrationEffectModifier: ViewModifier {
    var isDeleted: Bool
    var completion: () -> ()
    /// View Properties
    @State private var particles: [SnapParticle] = []
    @State private var animateEffect: Bool = false
    @State private var triggerSnapshot: Bool = false
    func body(content: Content) -> some View {
        content
            .opacity(particles.isEmpty ? 1 : 0)
            .overlay(alignment: .topLeading) {
                /// 8.This demonstrates that the particles have been successfully created and appears to be an entire image. You may have also noticed a slight delay when we press the button, This is not because we created multiple images; it's because all of those images were loaded simultaneously into the SwiftUI View. Let me show you.
                DisintegrationEffectView(particles: $particles, animateEffect: $animateEffect)

                /// 9.As you can see when we remove the SwiftUI view, the images are created instantly. Since views must be loaded on the Main thread, we can;t really do anything here. However, you can intraduce a dely so that the button animation completes, or you can remove the button and intraduce a tap gesture that won;t have any animations. I have some important techniques of how and where to use this effect, and you can check them out at the end of the video.
//                DisintegrationEffectView(particles: $particles, animateEffect: $animateEffect)
            }
            .snapshot(trigger: triggerSnapshot) { snapshot in
                Task.detached(priority: .high) {
                    try? await Task.sleep(for: .seconds(0.2))
                    await createParticles(snapshot)
                }
            }
        /// 2. This prevents the creation of multiple view particles.
            .onChange(of: isDeleted) { oldValue, newValue in
                if newValue && particles.isEmpty {
                    triggerSnapshot = true
                }
            }
    }

    private func createParticles(_ snapshot: UIImage) async {
        var particles: [SnapParticle] = []
        let size = snapshot.size
        let width = size.width
        let height = size.height
        /// 3.This is the maximum number of particles that can be created to achieve the disintegration effect. I suggest using less than 1100 particles, and if necessary, up to 1600 particles. However, using more than that is not recommended.
        let maxGridCount: Int = 1100
        
        var gridSize: Int = 1
        var rows = Int(height) / gridSize
        var columns = Int(width) / gridSize

        /// 4.This restricts the grid count to the specified maximum limit.
        while(rows * columns) >= maxGridCount {
            /// 5.IMPORTANT NOTE:
            /// I forgot to update it inside the while loop, so update it here as well. Which is,
            /// rows = Int(width) / gridSize
            /// columns = Int(height) / gridSize
            gridSize += 1
            rows = Int(width) / gridSize
            columns = Int(height) / gridSize
        }
        
        for row in 0...rows {
            for column in 0...columns {
                let positionX = column * gridSize
                let postionY = row * gridSize
                
                let cropRect = CGRect(x: positionX, y: postionY, width: gridSize, height: gridSize)
                let croppedImage = cropImage(snapshot, rect: cropRect)
                particles.append(.init(
                    particleImage: croppedImage,
                    particleOffset: .init(width: positionX, height: postionY)
                ))
            }
        }
        
        /// 7.Now that we've created the particles for the view, let's create another view to animated this and achieve the disintegration effect.
        await MainActor.run { [particles] in
            self.particles = particles
            /// Animating
            withAnimation(.easeInOut(duration: 1.5), completionCriteria: .logicallyComplete) {
                animateEffect = true
            } completion: {
                completion()
            }
        }
    }

    /// 6.This will crop the snapshot image to match the particle size and origin, resulting in a combined snapshot image. Since the disintegration effect will move and fade, I've reduced the image quality to the lowest settings here.
    private func cropImage(_ snapshot: UIImage, rect: CGRect) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: rect.size, format: format)
        
        return renderer.image { ctx in
            ctx.cgContext.interpolationQuality = .low
            snapshot.draw(at: .init(x: -rect.origin.x, y: -rect.origin.y))
        }
    }
}

fileprivate struct DisintegrationEffectView: View {
    @Binding var particles: [SnapParticle]
    @Binding var animateEffect: Bool
    var body: some View {
        ZStack(alignment: .topLeading) {
            ForEach(particles) { particle in
                Image(uiImage: particle.particleImage)
                    .offset(particle.particleOffset)
                    .offset(
                        x: animateEffect ? .random(in: -60...(-10)) : 0,
                        y: animateEffect ? .random(in: -100...(-10)) : 0
                    )
                    .opacity(animateEffect ? 0 : 1)
            }
        }
        .compositingGroup()
        /// 10.Don't introduce the blur to each particle individually, as it increases memory usage. That's why I introduced the compositeGroup and applied the blur as a whole view, not for each individual particle.
        .blur(radius: animateEffect ? 5 : 0)
    }
}

fileprivate struct SnapParticle: Identifiable {
    var id: String = UUID().uuidString
    var particleImage: UIImage
    var particleOffset: CGSize
}

#Preview {
    ContentView()
}
