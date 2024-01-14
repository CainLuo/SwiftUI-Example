//
//  ContentView.swift
//  OnboardingFlow
//
//  Created by Cain Luo on 2024/1/15.
//

import ConcentricOnboarding
import SwiftUI

struct ContentView: View {
    var body: some View {
        ConcentricOnboardingView(
            pageContents: [
                (OnboardingPage(title: "Send Message",
                                imageName: "message",
                                message: "Chat with all of your friends and send messages in groups!"), Color.blue),
                (OnboardingPage(title: "Notifications", imageName: "bell", message: "Enable push nofitications to stay up to date with friends and family."), Color.pink),
                (OnboardingPage(title: "Profile", imageName: "person.circle", message: "Customize your profile page to show others what you are into!"), Color.purple)
            ]
        )
        .duration(1.0)
        .nextIcon("chevron.forward")
        .animationDidEnd {
            print("Animation Did End")
        }
    }
}

struct OnboardingPage: View {
    
    let title: String
    let imageName: String
    let message: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(title)
                .font(.system(size: 40))
                .bold()
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(.white)
                .padding(100)

            Text(message)
                .font(.system(size: 28, weight: .light, design: .default))
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.white)

            Spacer()
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
