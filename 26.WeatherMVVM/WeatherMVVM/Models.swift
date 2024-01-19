//
//  Models.swift
//  WeatherMVVM
//
//  Created by Cain Luo on 2024/1/19.
//

import Foundation

struct WeatherModel: Codable {
    let timezoon: String
    let current: CurrentWeather
}

struct CurrentWeather: Codable {
    let temp: Float
    let weather: [WeatherInfo]
}

struct WeatherInfo: Codable {
    let main: String
    let description: String
    let icon: String
}


//{
//"lat": 40.7128,
//"lon": -74,
//"timezone": "America/New_York",
//"timezone_offset": -18000,
//    "current": {
//        "dt": 1612022528,
//        "sunrise": 1612008459,
//        "sunset": 1612044653,
//        "temp": 23.13,
//        "feels_like": 14.68,
//        "pressure": 1027,
//        "humidity": 54,
//        "dew_point": 10.49,
//        "uvi": 1.57,
//        "clouds": 1,
//        "visibility": 10000,
//        "wind_speed": 4.61,
//        "wind_deg": 0,
//        "weather": [
//            {
//                "id": 800,
//                "main": "Clear",
//                "description": "clear sky",
//                "icon": "01d"
//            }
//        ]
//    },
//"alerts": []
//}
