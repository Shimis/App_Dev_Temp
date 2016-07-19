//
//  LACity.h
//  objC vs Swift
//
//  Created by Alexander Larionov on 08.11.15.
//  Copyright © 2015 Alexander Larionov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LACity : NSObject
@property (strong, nonatomic) NSString * name;
@property (assign, nonatomic) NSInteger population;

- (instancetype)initWithName:(NSString*) name population:(NSInteger) population;

@end

@interface LACountry: NSObject
@property (strong,nonatomic) NSString * name;
@property (strong,nonatomic) NSArray * cities;

- (instancetype)initWithName:(NSString*) name cities:(NSArray*) cities;
- (LACity *)findCityByName:(NSString*)name;

@property (strong,nonatomic,readonly) LACity * cityWithLargetsPopulation;


@end