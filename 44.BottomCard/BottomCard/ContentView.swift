//
//  ContentView.swift
//  BottomCard
//
//  Created by Cain Luo on 2024/1/25.
//

import SwiftUI

struct ContentView: View {
    @State var cardShown = false
    @State var cardDismissal = false

    var body: some View {
        NavigationView {
            ZStack {
                Button(action: {
                    cardShown.toggle()
                    cardDismissal.toggle()
                }, label: {
                    Text("Show Card")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                })
                
                BottomCard(cardShown: $cardShown, 
                           cardDismissal: $cardDismissal, 
                           height: UIScreen.main.bounds.height / 2.2) {
                    CardContent()
                        .padding()
                }
                           .animation(.default)
            }
        }
    }
}

struct CardContent: View {
    var body: some View {
        Text("Photo Collage")
            .bold()
            .font(.system(size: 30))
            .padding()
        
        Text("You can create awesome photo grids and share them with all of your friends.")
            .font(.system(size: 18))
            .multilineTextAlignment(.center)
        
        Image(systemName: "square.and.arrow.up.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct BottomCard<Content: View>: View {
    let content: Content
    let height: CGFloat
    
    @Binding var cardShown: Bool
    @Binding var cardDismissal: Bool

    init(cardShown: Binding<Bool>,
         cardDismissal: Binding<Bool>,
         height: CGFloat,
        @ViewBuilder content: () -> Content) {
        _cardShown = cardShown
        _cardDismissal = cardDismissal
        self.height = height
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            // Dimmed
            GeometryReader { proxy in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(cardShown ? 1 : 0)
            .animation(.easeIn)
            .onTapGesture {
                // Dismiss
                self.dismiss()
            }
            
            // Card
            VStack {
                Spacer()
                VStack {
                    content
                    
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Text("Dismiss")
                            .frame(width: UIScreen.main.bounds.width / 1.3,
                                   height: 50)
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                    .padding()
                }
                .frame(height: height)
                .background(Color(UIColor.secondarySystemBackground))
                .offset(y: cardDismissal && cardShown ? 0 : height)
                .animation(.default.delay(0.2))
            }
        }
        .ignoresSafeArea(.all)
    }
    
    func dismiss() {
        cardDismissal.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            cardShown.toggle()
        }
    }
}

#Preview {
    ContentView()
}
