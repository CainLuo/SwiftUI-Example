//
//  ContentView.swift
//  SideMenu
//
//  Created by Cain Luo on 2024/1/18.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID()
    let text: String
    let imageNmae: String
    let handler: () -> Void = {
        print("Tapped item")
    }
}

struct MenuContent: View {
    let items: [MenuItem] = [
        MenuItem(text: "Home", imageNmae: "house"),
        MenuItem(text: "Profile", imageNmae: "person.circle"),
        MenuItem(text: "Activity", imageNmae: "bell"),
        MenuItem(text: "Flights", imageNmae: "airplane"),
        MenuItem(text: "Settings", imageNmae: "gear"),
        MenuItem(text: "Share", imageNmae: "square.and.arrow.up")
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1.0))
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(items) { item in
                    HStack {
                        Image(systemName: item.imageNmae)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                        
                        Text(item.text)
                            .foregroundColor(.white)
                            .bold()
                            .font(.system(size: 22))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    .onTapGesture {
//                        item.handler
                    }
                    .padding()
                    
                    Divider()
                }
                
                Spacer()
            }
            .padding(.top, 25)
        }
    }
}

struct SideMenu: View {
    
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    
    var body: some View {
        ZStack {
            // Dimmed background view
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.25))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.toggleMenu()
            }
            
            // MenuContent
            HStack {
                MenuContent()
                    .frame(width: width)
                    .offset(x: menuOpened ? 0 : -width)
                    .animation(.default)
                
                Spacer()
            }
        }
    }
}

struct ContentView: View {
    @State var menuOpened = false
    
    var body: some View {
        ZStack {
            if !menuOpened {
                Button {
                    // Open Menu
                    self.menuOpened.toggle()
                } label: {
                    Text("Open Menu")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color(.systemBlue))
                }
            }
            
            SideMenu(width: UIScreen.main.bounds.width / 1.8,
                     menuOpened: menuOpened,
                     toggleMenu: toggleMenu)

        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func toggleMenu() {
        menuOpened.toggle()
    }
}

#Preview {
    ContentView()
}
