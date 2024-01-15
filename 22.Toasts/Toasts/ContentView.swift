//
//  ContentView.swift
//  Toasts
//
//  Created by Cain Luo on 2024/1/15.
//

import SwiftUI
import PopupView

struct ContentView: View {
    @State var isShowingPopup = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.isShowingPopup.toggle()
                }, label: {
                    Text("Show Pop up")
                        .frame(width: 220,
                               height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                })
            }
            .popup(isPresented: $isShowingPopup, view: {
                Toasts()
            }, customize: {
                $0
                    .type(.floater())
                    .autohideIn(2)
                    .position(.top)
                    .animation(.spring())
                    .closeOnTapOutside(true)
                    .backgroundColor(.black.opacity(0.5))
            })
            .navigationTitle("SwiftUI Toasts")
        }
    }
}


#Preview {
    ContentView()
}

struct Toasts: View {
    var body: some View {
        HStack {
            Image(systemName: "bell")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.white)
                .padding()
            
            Text("You have 32 new messages waiting for you.")
                .padding()
                .foregroundColor(.white)
        }
        .background(Color.blue)
        .cornerRadius(12)
        .padding()
    }
}
