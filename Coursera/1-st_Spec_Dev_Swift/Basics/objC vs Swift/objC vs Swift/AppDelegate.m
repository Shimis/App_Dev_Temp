//
//  AppDelegate.m
//  Obj_C vs Swift (2)
//
//  Created by Alexander Larionov on 09.11.15.
//  Copyright © 2015 Alexander Larionov. All rights reserved.
//

#import "AppDelegate.h"
#import "LACity.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)loadStuff{
    NSArray * cities = @[
                         [[LACity alloc] initWithName:@"Moscow" population:15000000],
                         [[LACity alloc] initWithName:@"St.Peterburg" population: 8000000],
                         [[LACity alloc] initWithName:@"Samara" population:5000000]
                         ];
    LACountry * russia = [[LACountry alloc] initWithName:@"Russia" cities:cities];
    
    LACity * samara = [russia findCityByName:@"Samara"];
    
    LACity * Moscow = russia.cityWithLargetsPopulation;
    LACity * lagerstCity = [russia cityWithLargetsPopulation];
    
    
    NSDictionary* dict = @{@"Age": @23, @"Name": @"John"};
    
    
}

@end
