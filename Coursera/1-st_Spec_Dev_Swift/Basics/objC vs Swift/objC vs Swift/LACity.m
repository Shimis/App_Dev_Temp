//
//  LACity.m
//  objC vs Swift
//
//  Created by Alexander Larionov on 08.11.15.
//  Copyright © 2015 Alexander Larionov. All rights reserved.
//

#import "LACity.h"

@implementation LACity

- (instancetype)initWithName:(NSString*) name population:(NSInteger) population
{
    self = [super init];
    if (self) {
        self.name = name;
        self.population = population;
        
    }
    return self;
}

@end

@implementation LACountry

- (instancetype)initWithName:(NSString *)name cities:(NSArray *)cities
{
    self = [super init];
    if (self) {
        self.name = name;
        self.cities = cities;
    }
    return self;
}

- (LACity *)findCityByName:(NSString*)name
{
    for (LACity * city in self.cities){
        if ([city.name isEqualToString:name]) {
            return city;
        }
    }
    return nil;
}

- (LACity *)cityWithLargetsPopulation {
    NSInteger maxPopulation = 0;
    LACity * largetscity;
    
    for (LACity * city in self.cities) {
        if (city.population > maxPopulation){
            largetscity = city;
            maxPopulation = city.population;
        }
    }
    return largetscity; 
}

@end