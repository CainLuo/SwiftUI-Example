//
//  ContentView.swift
//  DatePicker
//
//  Created by Cain Luo on 2024/1/18.
//

import SwiftUI

struct ContentView: View {
    @State var date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Trip Date",
                           selection: $date,
                           in: Date()...Date().addingTimeInterval(24*3600*7))
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            }
            .navigationTitle("Select Dates")
        }
    }
}

#Preview {
    ContentView()
}
