//
//  ContentView.swift
//  WeatherMVVM
//
//  Created by Cain Luo on 2024/1/19.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.timezoon)
                    .font(.system(size: 32))
                Text(viewModel.temp)
                    .font(.system(size: 44))
                Text(viewModel.title)
                    .font(.system(size: 24))
                Text(viewModel.descriptionText)
                    .font(.system(size: 24))
            }
            .navigationTitle("Weater MVVM")
        }
    }
}

#Preview {
    ContentView()
}
