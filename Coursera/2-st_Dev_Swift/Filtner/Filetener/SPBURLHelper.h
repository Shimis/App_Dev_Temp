//
//  SPBURLHelper.h
//  Browser
//
//  Created by Denis Zamataev on 21/09/15.
//  Copyright © 2015 Sputnik LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSURL+IDN.h"

@interface SPBURLHelper : NSObject
+ (NSURL *)URLByCorrectingSchemeAndEncodingFromString:(NSString *)string;
@end
