//
//  ContentView.swift
//  Chart
//
//  Created by Cain Luo on 2023/12/24.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                LineChartView(data: [1.0, 10.0, 2.0, 31.0, 4.0, 50.0],
                              title: "Line Chart")
                
                Spacer()
                BarChartView(data: ChartData(values: [
                    ("Jan", 6),
                    ("Feb", 7),
                    ("Mar", 8),
                    ("Apr", 9),
                    ("May", 12)
                ]),
                             title: "Bar Chart")
                
                Spacer()
                PieChartView(data: [1.0, 10.0, 2.0],
                             title: "Pie Chart")
                
                Spacer()
                LineView(data: [1.0, 10.0, 2.0, 31.0, 4.0, 50.0], title: "Line View")
            }
        }
    }
}

#Preview {
    ContentView()
}
