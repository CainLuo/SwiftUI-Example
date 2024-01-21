//
//  ContentView.swift
//  CoolSwiftUICharts
//
//  Created by Cain Luo on 2024/1/21.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Legend
                    let iphone10 = Legend(color: .blue,
                                          label: "iPhone 10")
                    let iphone11 = Legend(color: .pink,
                                          label: "iPhone 11")
                    let iphone12 = Legend(color: .green,
                                          label: "iPhone 12")
                    let iphone8 = Legend(color: .orange,
                                          label: "iPhone 8")
                    let iphone5 = Legend(color: .yellow,
                                          label: "iPhone 5")
                    let iphone3g = Legend(color: .purple,
                                          label: "iPhone 3G")

                    // DataPoint
                    let points: [DataPoint] = [
                        .init(value: 2, label: "2", legend: iphone10),
                        .init(value: 4, label: "4", legend: iphone11),
                        .init(value: 6, label: "6", legend: iphone12),
                        .init(value: 8, label: "8", legend: iphone8),
                        .init(value: 4, label: "4", legend: iphone5),
                        .init(value: 12, label: "12", legend: iphone3g),
                        .init(value: 1, label: "1", legend: iphone8),
                        .init(value: 16, label: "16", legend: iphone3g),
                        .init(value: 18, label: "18", legend: iphone5)
                    ]
                    
                    // Line
                    Section(header: Text("Line Chart")) {
                        LineChartView(dataPoints: points)
                            .frame(height: UIScreen.main.bounds.height / 3)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                    }
                    
                    // Bar
                    Section(header: Text("Bar Chart")) {
                        BarChartView(dataPoints: points)
                            .frame(height: UIScreen.main.bounds.height / 3)
                            .padding()
                    }
                    
                    // Horizontal Bar
                    Section(header: Text("Horizontal Bar")) {
                        HorizontalBarChartView(dataPoints: points)
                            .frame(height: UIScreen.main.bounds.height / 3)
                            .padding()
                    }
                }
            }
            .navigationTitle("Charts & Graphs")
        }
    }
}

#Preview {
    ContentView()
}
