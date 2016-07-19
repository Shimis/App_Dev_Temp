//
//  AppDelegate.swift
//  objC vs Swift
//
//  Created by Alexander Larionov on 08.11.15.
//  Copyright © 2015 Alexander Larionov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func loadStuff() {
        let cities = [
            City(name: "Moscow", population: 15000000),
            City(name: "St.Peterburg", population: 8000000),
            City(name: "Samara", population: 500000)
        ]
        
        let russia = Country(name: "Russia", cities: cities)
        let samara = russia.findCityByName("Samara")
        let moscow = russia.cityWithLargetsPopulation
        
    
    }
    
    
    
}

