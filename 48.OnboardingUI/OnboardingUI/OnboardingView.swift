//
//  OnboardingView.swift
//  OnboardingUI
//
//  Created by Cain Luo on 2024/1/27.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        TabView {
            PageView(
                title: "Push Notifications",
                subtitle: "Enable notifications to stay up to date with our app.",
                imageName: "bell",
                shouldShowOnboarding: $shouldShowOnboarding
            )

            PageView(
                title: "Bookmarks",
                subtitle: "Save your favorite pieces of content",
                imageName: "bookmark",
                shouldShowOnboarding: $shouldShowOnboarding
            )

            PageView(
                title: "Filghts",
                subtitle: "Book flights to the places you want to go.",
                imageName: "airplane",
                shouldShowOnboarding: $shouldShowOnboarding
            )

            PageView(
                title: "Home",
                subtitle: "Go home whereever you might to",
                imageName: "house",
                showDismissButton: true,
                shouldShowOnboarding: $shouldShowOnboarding
            )
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct PageView: View {
    let title: String
    let subtitle: String
    let imageName: String
    var showDismissButton: Bool = false
    
    @Binding var shouldShowOnboarding: Bool

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding()
            
            Text(title)
                .font(.system(size: 32))
                .padding()
            
            Text(subtitle)
                .font(.system(size: 24))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(.secondaryLabel))
                .padding()
            
            if showDismissButton {
                Button(action: {
                    shouldShowOnboarding.toggle()
                }, label: {
                    Text("Get Started")
                        .bold()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
            }
        }
    }
}
