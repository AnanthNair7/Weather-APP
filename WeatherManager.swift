//
//  WeatherManager.swift
//  Clima
//
//  Created by Aravindh on 19/07/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager ,weather: WeatherModel )
    func didFailWithError(error : Error)
   
}
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=320c8bd81b7de4a63125f8a540c89665&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName : String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        perfromRequest(with:urlString)
    }
    
    func fetchWeather(lattitude:CLLocationDegrees,Longitude:CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(lattitude)&lon=\(Longitude)"
        perfromRequest(with: urlString)
    }
    
    
    func perfromRequest(with urlString : String){
        // 1.create a URL
        if  let url = URL(string: urlString) {
            // 2.create URLSessioin
            let session = URLSession (configuration: .default)
            // 3.Give the session task
            
            let task = session.dataTask(with: url){
                (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            
            // 4.Start the task
            task.resume()
        }
    }
     
    func parseJSON(_ wheaterData:Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: wheaterData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let city = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: city, temperture: temp  )
                return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
    
}

