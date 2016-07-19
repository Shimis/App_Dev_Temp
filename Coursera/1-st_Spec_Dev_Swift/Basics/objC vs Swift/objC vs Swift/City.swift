//
//  City.swift
//  objC vs Swift
//
//  Created by Alexander Larionov on 08.11.15.
//  Copyright © 2015 Alexander Larionov. All rights reserved.
//

import UIKit

class City {
    let name : String
    var population : Int
    init (name:String, population: Int){
        self.name = name
        self.population = population
    }
    
}

class Country {
    let name : String
    let cities : [City]
    init (name: String, cities: [City]){
        self.name = name
        self.cities = cities
    }
    func findCityByName (name: String) -> City?{
        for city in cities{
            if city.name == name{
                return city
            }
            
        }
        return nil
    }
    var cityWithLargetsPopulation : City{
        var maxPopulation = 0
        var largetsCity = cities[0]
        for city in cities{
            if city.population > maxPopulation{
                largetsCity = city
                maxPopulation = city.population
            }
        }
        return largetsCity
        
    }
    
}