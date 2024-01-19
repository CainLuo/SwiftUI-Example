//
//  ViewModel.swift
//  WeatherMVVM
//
//  Created by Cain Luo on 2024/1/19.
//

import Foundation

// Date needed by view

class WeatherViewModel: ObservableObject {
    @Published var title: String = "-"
    @Published var descriptionText: String = "-"
    @Published var temp: String = "-"
    @Published var timezoon: String = "-"
    
    init() {
        fetchWeather()
    }
    
    func fetchWeather() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.title = "Clear"
            self.descriptionText = "clear sky"
            self.temp = "23.13"
            self.timezoon = "America/New_York"
        }
        
        guard let url = URL(string: "") else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let model = try JSONDecoder().decode(WeatherModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.title = model.current.weather.first?.main ?? "No Title"
                    self.descriptionText = model.current.weather.first?.description ?? "No Description"
                    self.temp = "\(model.current.temp)"
                    self.timezoon = model.timezoon
                }
            } catch {
                
            }
        }
        
        task.resume()
    }
}
