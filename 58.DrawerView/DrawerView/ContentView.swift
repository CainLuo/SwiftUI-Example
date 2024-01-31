//
//  ContentView.swift
//  DrawerView
//
//  Created by Cain Luo on 2024/1/31.
//

import SwiftUI

struct ContentView: View {
    @State private var offset: CGFloat = 200
    @State private var isInitialOffsetSet = false

    var body: some View {
        ZStack {
            HomeView()
            
            GeometryReader { proxy in
                ZStack {
                    BlurView(style: .systemThinMaterialDark)
                    
                    DrawerView()
                }
            }
            .offset(y: offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let startLocation = value.startLocation
                        offset = startLocation.y + value.translation.height
                    }
            )
            .onAppear {
                if !isInitialOffsetSet {
                    offset = UIScreen.main.bounds.height - 150
                    isInitialOffsetSet = true
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}

// Blur View

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    }
    
    typealias UIViewType = UIVisualEffectView
}

// HomeView

struct HomeView: View {
    var body: some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .global)
            Image(systemName: "square.and.arrow.up.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: frame.size.width,
                       height: frame.size.height)
        }
    }
}

// Drawer View

struct DrawerView: View {
    @State var text = ""
    
    var body: some View {
        VStack {
            Capsule()
                .frame(width: 100, height: 7)
                .foregroundColor(.white)
                .padding(.top, 7)
            
            TextField("Search", text: $text)
                .padding()
                .background(Color(.label))
                .cornerRadius(7)
                .opacity(0.7)
                .padding(12)
            
            HStack(alignment: .center, spacing: 25) {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "bell")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .clipShape(Circle())
                })
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "airplane")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.yellow)
                        .clipShape(Circle())
                })

                Button(action: {
                    
                }, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.pink)
                        .clipShape(Circle())
                })
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "house")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.purple)
                        .clipShape(Circle())
                })
            }
            
            Spacer()
        }
    }
}
