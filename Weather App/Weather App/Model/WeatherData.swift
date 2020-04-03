//
//  WeatherData.swift
//  Weather App
//
//  Created by Ali Farhadi on 1/7/1399 AP.
//  Copyright © 1399 Ali.Farhadi. All rights reserved.
//

import Foundation

struct WeatherData {
    
    let temp: Double
    let minTemp: Double
    let maxTemp: Double
    let description: [String]
    let id: [Int?]
    
    // Convert weather condition id to suitable imageName
    func getImageName(with id:Int) -> String {
        
        switch id {
        case 200...232 :
            return("cloud.bolt.rain")
        case 300...321 :
            return("cloud.drizzle")
        case 500...502 :
            return("cloud.rain")
        case 503...531 :
            return("cloud.heavyrain")
        case 600...622 :
            return("cloud.snow")
        case 701...781 :
            return("cloud.fog")
        case 800 :
            return("sun.min")
        case 801...804 :
            return("cloud")
        default:
            return("sun.min")
        }
    }
    
    
}
