//
//  ContentView.swift
//  AppUpsell
//
//  Created by Cain Luo on 2024/1/28.
//

import StoreKit
import SwiftUI

struct ContentView: View {
    @State var appSotreOverlayPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    appSotreOverlayPresented.toggle()
                }, label: {
                    Label(
                        title: { Text("Download Now")
                                .foregroundColor(.white)
                        },
                        icon: { Image(systemName: "square.and.arrow.down.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 55, height: 55)
                                .cornerRadius(8)
                        }
                    )
                    .frame(width: 300)
                    .padding()
                    .background(Color.black)
                    .clipShape(Capsule())
                })
                .appStoreOverlay(isPresented: $appSotreOverlayPresented) {
                    SKOverlay.AppConfiguration(appIdentifier: "id440948110",
                                               position: .bottom)
                }
            }
            .navigationTitle("App Upsell")
        }
    }
}

#Preview {
    ContentView()
}
