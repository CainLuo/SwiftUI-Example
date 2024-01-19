//
//  ContentView.swift
//  MapView
//
//  Created by Cain Luo on 2024/1/15.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader(content: { geometry in
                    MapView(coordinate2D: CLLocationCoordinate2D(latitude: 23.8, longitude: 113.17))
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                })
            }
            .navigationTitle("SwiftUI Map View")
        }
    }
}

#Preview {
    ContentView()
}
