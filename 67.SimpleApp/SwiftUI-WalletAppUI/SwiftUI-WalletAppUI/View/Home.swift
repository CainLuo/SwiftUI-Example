//
//  Home.swift
//  SwiftUI-WalletAppUI
//
//  Created by Cain on 2024/12/6.
//

import SwiftUI

struct Home: View {
    var size: CGSize
    var safeArea: EdgeInsets
    /// View Properties
    @State private var showDetailView: Bool = false
    @State private var selectedCard: Card?
    @Namespace private var animation
    var body: some View {
        /// ScrollView With Cards UI
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                Text("My Wallet")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .trailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 35, height: 35)
                                .foregroundStyle(.black)
                                .clipShape(.circle)
                        }
                    }
                    /// Let's make it fade away when detail view is expanding
                    .blur(radius: showDetailView ? 5 : 0)
                    .opacity(showDetailView ? 0 : 1)
                
                /// Cards View
                /// Also modify the main offset to show the selected card
                let mainOffset = CGFloat(cards.firstIndex(where: { $0.id == selectedCard?.id }) ?? 0) * -size.width
                
                /// Note: If you use VStack here, you must move the view -15 beacuse of the padding applied, for when using LazyVStack it's not required
                LazyVStack(spacing: 10) {
                    ForEach(cards) { card in
                        /// Let's convert thsi scrollview to horizontal without changing any of it's properties and by just using the offset modifier
                        let cardOffset = CGFloat(cards.firstIndex(where: { $0.id == card.id }) ?? 0) * size.width
                        
                        CardView(card)
                            /// Making it to occupy the full screen width
                            .frame(width: showDetailView ? size.width : nil)
                            /// Now, let's move all the cards to the top using visualEffect modifier
                            .visualEffect { [showDetailView] content, proxy in
                                content
                                    .offset(
                                        x: showDetailView ? cardOffset : 0,
                                        y: showDetailView ? -proxy.frame(in: .scrollView).minY : 0
                                    )
                            }
                    }
                }
                .padding(.top, 25)
                .offset(x: showDetailView ? mainOffset : 0)
            }
            /// Again, the reason for not modifying the main view's frame is to preserve it's scroll position when it's coming back from detail view to the home view!
            .safeAreaPadding(15)
            .safeAreaPadding(.top, safeArea.top)
        }
        /// When Detail view is expanded the scroll interactions of the parent view is disbled
        .scrollDisabled(showDetailView)
        .scrollIndicators(.hidden)
        .overlay {
            if let selectedCard, showDetailView {
                DetailView(selectedCard: selectedCard)
                    .padding(.top, expandedCardHeight)
                    .transition(.move(edge: .bottom))
            }
        }
    }
    
    @ViewBuilder
    func CardView(_ card: Card) -> some View {
        /// Adapting Card View when it's getting expanded
        ZStack {
            Rectangle()
                .fill(card.color.gradient)
            
            /// Card Details View
            VStack(alignment: .leading, spacing: 15) {
                if !showDetailView {
                    VisaImageView(card.visaGeometryID, height: 20)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(card.number)
                        .font(.caption)
                        .foregroundStyle(.white.secondary)
                    
                    Text("$3878.98")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: showDetailView ? .center : .leading)
                .overlay {
                    ZStack {
                        /// Moving the Visa View here with the help of MatchedGeometry Effect
                        if showDetailView {
                            VisaImageView(card.visaGeometryID, height: 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                /// Let's move to close to the date
                                .offset(y: 45)
                        }
                        
                        /// Let's create a close button and which will be only visible to the selected card
                        if let selectedCard, selectedCard.id == card.id, showDetailView {
                            Button {
                                /// Closing the view
                                withAnimation(.smooth(duration: 0.5, extraBounce: 0)) {
                                    self.selectedCard = nil
                                    showDetailView = false
                                }
                                
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                    .contentShape(.rect)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .transition(.asymmetric(insertion: .opacity, removal: .identity))
                        }
                    }
                }
                .padding(.top, showDetailView ? safeArea.top - 10 : 0)
                
                HStack {
                    Text("Expires: \(card.expires)")
                        .font(.caption)

                    Spacer()

                    Text("iJUSTINE")
                        .font(.callout)
                }
                .foregroundStyle(.white.secondary)
            }
            .padding(showDetailView ? 15 : 25)
        }
        /// Let's Modify the card's height for the detail view
        .frame(height: showDetailView ? expandedCardHeight : nil)
        /// The reason for this is unchanged, becasue it preserves the scroll position of the parent view when coming back from the detail view to the home view!
        .frame(height: 200, alignment: .top)
        .clipShape(.rect(cornerRadius: showDetailView ? 0 : 25))
        .onTapGesture {
            /// Closing action will be done by the back button
            guard !showDetailView else { return }
            withAnimation(.smooth(duration: 0.5, extraBounce: 0)) {
                selectedCard = card
                showDetailView = true
            }
        }
    }
    
    @ViewBuilder
    func VisaImageView(_ id: String, height: CGFloat) -> some View {
        Image(.visa)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .matchedGeometryEffect(id: id, in: animation)
            .frame(height: height)
    }
    
    /// I need the card to be occupied to the safeArea top when it's expanded, thus let's modify the expanded height with the inclusion of the safe area value
    var expandedCardHeight: CGFloat {
        safeArea.top + 130
    }
}

struct DetailView: View {
    var selectedCard: Card
    var body: some View {
        /// YOUR CUSTOM DETAIL CONTENTS HERE
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 12) {
                Text("Details")
                
                Spacer(minLength: 0)

                ForEach(1...20, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.black.gradient)
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(15)
        }
    }
}

#Preview {
    ContentView()
}
