//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Luiz Oliveira on 26/01/24.
//


import UIKit


// MARK: - Weather
struct Weather: Codable {
    let coord: Coord
    let weather: [WeatherElement]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}



class Service {
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let APIKEY = "3cc0fe1c6bb024dc878d7aea242092bf"
    private let session = URLSession.shared
    
    func fetchData(city: String, _ completion: @escaping (Weather?) -> Void) {
    
        guard let url = URL(string: "\(baseURL)?&units=metric&q=\(city)&appid=\(APIKEY)") else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(nil)
                return
            }
            
            do {
                let WeatherResponse = try? JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    completion(WeatherResponse)
                }
            } catch {
                print(error)
                completion(nil)
            }
            
        }
        task.resume()
    }
    
}
