//
//  ContentView.swift
//  Gauge Watch App
//
//  Created by Cain Luo on 2023/12/16.
//

import SwiftUI

struct ContentView: View {
    var gradint = Gradient(colors: [.blue, .pink, .purple, .orange])
    
    var body: some View {
        Gauge(value: 33.0, in: 0.0...100.0, label: {
            Text("Speed")
                .foregroundColor(.blue)
        }, currentValueLabel: {
            Text("33")
                .foregroundColor(.blue)
        }, minimumValueLabel: {
            Text("0")
                .foregroundColor(.blue)
        }, maximumValueLabel: {
            Text("100")
                .foregroundColor(.blue)
        })
        .gaugeStyle(CircularGaugeStyle(tint: gradint))
    }
}

#Preview {
    ContentView()
}
