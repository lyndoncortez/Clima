//
//  WeatherManager.swift
//  Klima
//
//  Created by  LYNDON on 3/16/21.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWitherror(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=2aaaaa5c0b8e608c6637892e55552f6b&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlText = "\(weatherURL)&q=\(cityName)"
        let urlString = urlText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URL Session
            let session = URLSession(configuration: .default)
            
            
            //3. Give the session a task
            let task =  session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWitherror(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            
            //4. Start the task
            task.resume()
            
        }
            
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            print("LOCATION: \(decodedData.name)")
//            print("WEATHER: \(decodedData.weather[0].description)")
//            print("TEMPERATURE: \(decodedData.main.temp)")
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let desc = decodedData.weather[0].description
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: desc)
            return weather
        } catch {
            delegate?.didFailWitherror(error: error)
            return nil
        }
        
    }
        
}
