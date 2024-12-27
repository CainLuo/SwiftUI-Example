//
//  ContentView.swift
//  SwiftUI-MailTabBar
//
//  Created by Cain on 2024/11/21.
//

import SwiftUI

struct ContentView: View {
    /// View Properties
    @State private var searchText: String = ""
    @State private var isSearchActive: Bool = false
    @State private var activeTab: TabModel = .primary
    /// Scroll Properties
    @State private var scrollOffset: CGFloat = 0
    @State private var topInset: CGFloat = 0
    @State private var startTopInset: CGFloat = 0
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    CustomTabBar(activeTab: $activeTab)
                    /// 10.Sometimes, we don't want the tab bar to be displayed when a search bar is displayed. Let's add that criteria as well.
                        .frame(height: isSearchActive ? 0 : nil, alignment: .top)
                        .opacity(isSearchActive ? 0 : 1)
                        .padding(.bottom, isSearchActive ? 0 : 10)
                        .background {
                            let progress = min(max((scrollOffset + startTopInset - 110) / 15, 0), 1)
                            
                            ZStack(alignment: .bottom) {
                                Rectangle()
                                    .fill(.ultraThinMaterial)
                                
                                /// Divider
                                Rectangle()
                                    .fill(.gray.opacity(0.3))
                                    .frame(height: 1)
                            }
                            .padding(.top, -topInset)
                            .opacity(progress)
                            /// 9.The purpose of storing the startTopInset property is to allow us to display the background at any desired location. For instance, if I don't want to show the background only after it's stuck to the top, but rather want it to appear in the middle, I can achieve that with the help of this property.
                            ///  For now, let's show the background only after it's stuck at the top.
                        }
                        .offset(y: (scrollOffset + topInset) > 0 ? (scrollOffset + topInset) : 0)
                        .zIndex(1000)
                                        
                    /// YOUR OTHER VIEW HERE
                    LazyVStack(alignment: .leading) {
                        Text("Mails")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(15)
                    .zIndex(0)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: isSearchActive)
            /// 7.Until now, the code written for the custom tab bar has been supported for previous versions of iOS. The upcoming part is only for iOS 18+.
            /// Let's remove the default navigation bar background and add a custom background that behaves similarly to the default one but also includes our tab bar.
            .onScrollGeometryChange(for: CGFloat.self, of: {
                $0.contentOffset.y
            }, action: { oldValue, newValue in
                scrollOffset = newValue
            })
            .onScrollGeometryChange(for: CGFloat.self, of: {
                $0.contentInsets.top
            }, action: { oldValue, newValue in
                if startTopInset == .zero {
                    startTopInset = newValue
                }
                topInset = newValue
            })
            .navigationTitle("All Inboxes")
            .searchable(text: $searchText, isPresented: $isSearchActive, placement: .navigationBarDrawer(displayMode: .automatic))
            .background(.gray.opacity(0.1))
            /// 8.Now, we've made the tab bar sticky, so let's modify its background.
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        }
    }
}

struct CustomTabBar: View {
    @Binding var activeTab: TabModel
    @Environment(\.colorScheme) private var scheme
    var body: some View {
        GeometryReader { _ in
            HStack(spacing: 8) {
                HStack(spacing: activeTab == .allMails ? -15 : 8) {
                    ForEach(TabModel.allCases.filter({ $0 != .allMails }), id: \.rawValue) { tab in
                        ResizableTabButton(tab)
                    }
                }
                
                if activeTab == .allMails {
                    ResizableTabButton(.allMails)
                        .transition(.offset(x: 200))
                }
            }
            .padding(.horizontal, 15)
        }
        .frame(height: 50)
    }

    @ViewBuilder
    func ResizableTabButton(_ tab: TabModel) -> some View {
        HStack(spacing: 8) {
            Image(systemName: tab.symbolImage)
                .opacity(activeTab != tab ? 1 : 0)
                .overlay {
                    /// 5.Now, let's add the "All Mails" tab at the end of the current tab bar. This tab will only be visible when the currently active tab is pressed again. Once pressed. all the main tabs will be minimized, and the new "All Mails" tab will appear on the trailing side of the tab bar.
                    Image(systemName: tab.symbolImage)
                        .symbolVariant(.fill)
                        .opacity(activeTab == tab ? 1 : 0)
                }
                    /// 4.The symbolVariant modifier doesn't actually reflect animations on it, so let's create a custom view to make the symbol to get animated.
//                .symbolVariant(activeTab == tab ? .fill : .none)
            
            if activeTab == tab {
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(1)
            }
        }
        .foregroundStyle(tab == .allMails ? schemeColor : activeTab == tab ? .white : .gray)
        .frame(maxHeight: .infinity)
        /// 3.Let's ensure that the active tab occupies the entire available space.
        .frame(maxWidth: activeTab == tab ? .infinity : nil)
        .padding(.horizontal, activeTab == tab ? 10 : 20)
        .background {
            Rectangle()
                .fill(activeTab == tab ? tab.color : .inActiveTab)
        }
        .clipShape(.rect(cornerRadius: 20, style: .continuous))
        /// 6.To make the overlapping view more visually appealing, let's add some background to it.
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.background)
                .padding(activeTab == .allMails && tab != .allMails ? -3 : 3)
        }
        .contentShape(.rect)
        .onTapGesture {
            guard tab != .allMails else { return }
            withAnimation(.bouncy) {
                if activeTab == tab {
                    activeTab = .allMails
                } else {
                    activeTab = tab
                }
            }
        }
    }
    
    var schemeColor: Color {
        scheme == .dark ? .black : .white
    }
}

#Preview {
    ContentView()
}
