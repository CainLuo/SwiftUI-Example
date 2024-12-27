//
//  DetailView.swift
//  SwiftUI-NavigationStackHeroAnimation
//
//  Created by Cain on 2024/11/25.
//

import SwiftUI

/// Detail View
struct DetailView: View {
    @Binding var selectedProfile: Profile?
    var profile: Profile
    @Binding var config: HeroConfiguration
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                ForEach(messages) { message in
                    MessageCardView(message: message)
                }
            }
            .padding(15)
        }
        .safeAreaInset(edge: .top) {
            if #unavailable(iOS 18) {
                CustomHeaderView()
                    .padding(.vertical, 15)
                    .background {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                    }
            } else {
                CustomHeaderView()
                    .padding(.top, -25)
                    .padding(.bottom, 15)
                    .background {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                    }
            }
        }
        .hideNavbarBackground()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                config.isExpandedCompletely = true
            }
        }
    }
    
    /// Custom Header View
    @ViewBuilder
    func CustomHeaderView() -> some View {
        VStack(spacing: 6) {
            ZStack {
                if selectedProfile != nil {
                    Image(systemName: profile.profilePicture)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(.circle)
                        .opacity(config.isExpandedCompletely ? 1 : 0)
                        .onGeometryChange(for: CGRect.self) {
                            $0.frame(in: .global)
                        } action: { newValue in
                            config.coordinates.1 = newValue
                        }
                        .transition(.identity)
                }
            }
            .frame(width: 50, height: 50)
            
            Button {
                
            } label: {
                HStack(spacing: 2) {
                    Text(profile.userName)
                    
                    Image(systemName: "chevron.right")
                        .font(.caption2)
                }
                .font(.caption2)
                .foregroundStyle(Color.primary)
                .contentShape(.rect)
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topLeading) {
            /// 14.If you remove the navigation bar from the detail view, you must also remove it from the home view.
            if #unavailable(iOS 18) {
                Button {
                    selectedProfile = nil
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.trailing, 20)
                        .contentShape(.rect)
                }
                .padding(.leading, 15)
            }
        }
        /// 6.We don't want to remove the navigation bar. If we do, we lose the back button with an interactive dismissal option. So, simply move the view a bit up with nagatice padding.
//        .padding(.top, -25)
//        .padding(.bottom, 15)
//        .background {
//            Rectangle()
//                .fill(.ultraThinMaterial)
//                .ignoresSafeArea()
//        }
    }
    
    /// 7.Now, let's implement the fundamental logic for the custom hero effect.
}

#Preview {
    Home()
}
