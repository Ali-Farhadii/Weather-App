//
//  CityModel.swift
//  Weather App
//
//  Created by Ali Farhadi on 1/7/1399 AP.
//  Copyright © 1399 Ali.Farhadi. All rights reserved.
//

import Foundation

struct CityModel {
    
    var countryName = ""
    var cityName = [""]
    
    func getData() -> [CityModel] {
            
        var modelArray = [CityModel]()
        
        modelArray.append(CityModel(countryName: "USA", cityName: ["New York City","Las Vegas","Miami","Los Angeles","Orlando","San Francisco","Honolulu","Washington D.C"]))
        modelArray.append(CityModel(countryName: "Iran", cityName: ["Shiraz","Hamadan","Isfahan","Ahvaz","Tabriz","Mashhad","Qom"]))
        modelArray.append(CityModel(countryName: "Australia", cityName: ["Sydney","Melbourne","Brisbane"]))
        modelArray.append(CityModel(countryName: "UK", cityName: ["London","Liverpool","Manchester","Derby","Cambridge"]))
        
        return modelArray
    }
}
