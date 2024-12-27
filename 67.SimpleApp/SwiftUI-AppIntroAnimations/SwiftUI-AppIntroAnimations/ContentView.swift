//
//  ContentView.swift
//  SwiftUI-AppIntroAnimations
//
//  Created by Cain on 2024/12/5.
//

import SwiftUI

struct ContentView: View {
    /// View Properties
    @State private var selectedItem: Item = items.first!
    @State private var introItems: [Item] = items
    @State private var activeIndex: Int = 0
    var body: some View {
        /// Now Let's Start Building the actual Intro Page UI
        VStack(spacing: 0) {
            /// Back Button
            Button {
                updateItem(isForward: false)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3.bold())
                    .foregroundStyle(.green.gradient)
                    .contentShape(.rect)
            }
            .padding(15)
            .frame(maxWidth: .infinity, alignment: .leading)
            /// Only Visible from second item
            .opacity(selectedItem.id != introItems.first?.id ? 1 : 0)
            
            ZStack {
                /// Animated Icons
                /// Let's Get started with the animated icons
                ForEach(introItems) { item in
                    AnimatedIconView(item)
                }
            }
            .frame(height: 250)
            .frame(maxHeight: .infinity)

            VStack(spacing: 6) {
                /// Progress Indicator View
                HStack(spacing: 4) {
                    ForEach(introItems) { item in
                        Capsule()
                            .fill(selectedItem.id == item.id ? Color.primary : .gray)
                            .frame(width: selectedItem.id == item.id ? 25 : 4, height: 4)
                    }
                }
                .padding(.bottom, 15)
                
                Text(selectedItem.title)
                    .font(.title.bold())
                    .contentTransition(.numericText())
                
                /// YOUR CUSTOM DESCRIPTION HERE
                Text("Lorem Ipsum is simply dummy text.")
                    .font(.caption2)
                    .foregroundStyle(.gray)
                
                /// Next/Continue Button
                Button {
                    updateItem(isForward: true)
                } label: {
                    Text(selectedItem.id == introItems.last?.id ? "Continue" : "Next")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .contentTransition(.numericText())
                        .frame(width: 250)
                        .padding(.vertical, 12)
                        .background(.green.gradient, in: .capsule)
                }
                .padding(.top, 25)
            }
            .multilineTextAlignment(.center)
            .frame(width: 300)
            .frame(maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    func AnimatedIconView(_ item: Item) -> some View {
        let isSelected = selectedItem.id == item.id
        
        Image(systemName: item.image)
            .font(.system(size: 80))
            .foregroundStyle(.white.shadow(.drop(radius: 10)))
            .blendMode(.overlay)
            .frame(width: 120, height: 120)
            .background(.green.gradient, in: .rect(cornerRadius: 32))
            .background(
                RoundedRectangle(cornerRadius: 35)
                    .fill(.background)
                    .shadow(color: .primary.opacity(0.2), radius: 1, x: 1, y: 1)
                    .shadow(color: .primary.opacity(0.2), radius: 1, x: -1, y: -1)
                    .padding(-3)
                    .opacity(selectedItem.id == item.id ? 1 : 0)
            )
            /// Resetting Rotating
            .rotationEffect(.init(degrees: -item.rotation))
            .scaleEffect(isSelected ? 1.1 : item.scale, anchor: item.anchor)
            .offset(x: item.offset)
            .rotationEffect(.init(degrees: item.rotation))
            /// Placing active icon at the top
            .zIndex(isSelected ? 2 : item.zindex)
    }
    
    /// Let's shift active icon to the center when continue or back button is pressed
    func updateItem(isForward: Bool) {
        /// Now let's implement backwards interaction as well
        
        guard isForward ? activeIndex != introItems.count - 1 : activeIndex != 0 else { return }
        var fromIndex: Int
        var extraOffset: CGFloat
        /// To Index
        if isForward {
            activeIndex += 1
        } else {
            activeIndex -= 1
        }
        /// From Index
        
        if isForward {
            fromIndex = activeIndex - 1
            extraOffset = introItems[activeIndex].extraOffset
        } else {
            extraOffset = introItems[activeIndex].extraOffset
            fromIndex = activeIndex + 1
        }
        
        /// Resetting ZIndex
        for index in introItems.indices {
            introItems[index].zindex = 0
        }
        
        /// Swift 6 Error
        Task { [fromIndex, extraOffset] in
            /// Shifting rom and to icon locations
            withAnimation(.bouncy(duration: 1)) {
                introItems[fromIndex].scale = introItems[activeIndex].scale
                introItems[fromIndex].rotation = introItems[activeIndex].rotation
                introItems[fromIndex].anchor = introItems[activeIndex].anchor
                introItems[fromIndex].offset = introItems[activeIndex].offset
                /// Temporary Adjustment
                /// Why there is not much of any difference is that, let longer the duration gets the value must also get larger
                introItems[activeIndex].offset = extraOffset
                /// The moment selected item is updated, it pushes the from card all the way to the back in terms of the zIndex
                /// To solve this we can make use of ZIndex property to just place the from card below the to card
                /// EG: To card Postion: 2
                /// From Card Postion: 1
                /// Others 0
                introItems[fromIndex].zindex = 1
            }
            
            try? await Task.sleep(for: .seconds(0.1))
            
            withAnimation(.bouncy(duration: 0.9)) {
                /// To location is always at the center
                introItems[activeIndex].scale = 1
                introItems[activeIndex].rotation = .zero
                introItems[activeIndex].anchor = .center
                introItems[activeIndex].offset = .zero
                
                /// Updating Selected Item
                selectedItem = introItems[activeIndex]
            }
        }
    }
}

#Preview {
    ContentView()
}
