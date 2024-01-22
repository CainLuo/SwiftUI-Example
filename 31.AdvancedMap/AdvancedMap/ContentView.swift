//
//  ContentView.swift
//  AdvancedMap
//
//  Created by Cain Luo on 2024/1/22.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State var isZoom = false
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 23.8, longitude: 113.17),
        span: MKCoordinateSpan(
            latitudeDelta: 40,
            longitudeDelta: 40
        )
    )
    
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $region)
                
                Button(action: {
                    withAnimation {
                        region.span = MKCoordinateSpan(
                            latitudeDelta: isZoom ? 40 : 5,
                            longitudeDelta: isZoom ? 40 : 5
                        )
                    }
                    isZoom.toggle()
                }, label: {
                    Text("Zoom In")
                        .frame(width: 250, height: 50)
                        .background(Color.green)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
