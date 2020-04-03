//
//  WeatherManager.swift
//  Weather App
//
//  Created by Ali Farhadi on 1/7/1399 AP.
//  Copyright © 1399 Ali.Farhadi. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol WeatherManagerProtocol {
    func updateUI(with weatherModel:WeatherData)
    func failWithError(_ error:ErrorType)
}

enum ErrorType {
    case url
    case network
    case parse
}

struct WeatherManager {
    
    let scheme = "https"
    let host = "api.openweathermap.org"
    let path = "/data/2.5/weather"
    let appId = URLQueryItem(name: "appid", value: "3dbaa80104a1c23e3e6116da39aa26e4")
    let units = URLQueryItem(name: "units", value: "metric")
    
    var delegate:WeatherManagerProtocol?
    
    func makeRequest(with cityName:String) {
    
        let safeCityName = URLQueryItem(name: "q", value: "\(cityName)")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [appId,units,safeCityName]
        
        guard let url = urlComponents.url else {
            print("error in making url")
            self.delegate?.failWithError(.url)
            return
        }
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("error in make request")
                self.delegate?.failWithError(.network)
            }
            guard let safeData = data else {
                return
            }
            
            if let parsedData = self.parseJSON(safeData) {
                self.delegate?.updateUI(with: parsedData)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ weatherData:Data) -> WeatherData? {
        
        do {
            let data = try JSON(data: weatherData)
            let temp = data["main","temp"].doubleValue
            let minTemp = data["main","temp_min"].doubleValue
            let maxTemp = data["main","temp_max"].doubleValue
            let description = data["weather"].arrayValue.map {$0["description"].stringValue}
            let id = data["weather"].arrayValue.map {$0["id"].int}
            
            let weatherModel = WeatherData(temp: temp, minTemp: minTemp, maxTemp: maxTemp, description: description, id: id)
            
            return weatherModel
        }
        catch {
            self.delegate?.failWithError(.parse)
            return nil
        }
    }
        
}
