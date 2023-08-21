//
//  WheaterData.swift
//  Clima
//
//  Created by Ananth Nair on 21/08/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit

struct WeatherData : Codable {
    
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main : Codable {
    let temp : Double
}

struct Weather : Codable {
    let id : Int
    let description : String
    
}
