//
//  WeatherModel.swift
//  Clima
//
//  Created by Ananth Nair on 21/08/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    var conditionId : Int
    var cityName : String
    var temperture : Double
    
    var temperatureString : String {
        return String(format: "%.1f", temperture)
    }
    
    
    var conditionName : String {
        switch  conditionId {
        case 200...232:
            return "cloud.blot"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
     
    
}
