//
//  SPBURLHelper.m
//  Browser
//
//  Created by Denis Zamataev on 21/09/15.
//  Copyright © 2015 Sputnik LLC. All rights reserved.
//

#import "SPBURLHelper.h"

@implementation SPBURLHelper
+ (NSURL *)URLByCorrectingSchemeAndEncodingFromString:(NSString *)string
{
    if (string == nil || string.length == 0) {
        return nil;
    }
    
    if ([string rangeOfString:@" "].location != NSNotFound) {
        return nil;
    }
    
    BOOL thatCanBeURL = NO;
    
    NSString *ipPattern =
    @"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}(:\\d+|/.*|$)";
    NSRegularExpression *ipRegex = [NSRegularExpression regularExpressionWithPattern:ipPattern
                                                                             options:NSRegularExpressionCaseInsensitive
                                                                               error:nil];
    NSArray *matched = [ipRegex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    if (matched.count > 0) {
        thatCanBeURL = YES;
    }
    
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSUInteger countMatches = [detector numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
    if (countMatches > 0) {
        thatCanBeURL = YES;
    }
    
    if (thatCanBeURL) {
        // parse & encode
        NSString *stringToEncode = string;
        
        // check and correct scheme if needed
        NSArray *schemeAndHierarchicalPartComponents = [string componentsSeparatedByString:@"://"];
        if (schemeAndHierarchicalPartComponents.count < 2) {
            // we will add default scheme
            NSString *scheme = @"http";
            NSString *hierarchicalPart = string;
            
            stringToEncode = [NSString stringWithFormat:@"%@://%@", scheme, hierarchicalPart];
        }
        
        NSURL *standardURL = [NSURL URLWithString:stringToEncode];
        if (standardURL) {
            return standardURL;
        }
        
        // now string might need some proper encoding
        NSString *encodedString = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"https?://[^/]+" options:0 error:NULL];
        NSTextCheckingResult *match = [regex firstMatchInString:stringToEncode options:0 range:NSMakeRange(0, [stringToEncode length])];
        if (match.range.length > 0 && (match.range.length + match.range.location) < stringToEncode.length) {
            NSString *hostString = nil;
            NSString *pathString = nil;
            hostString = [stringToEncode substringToIndex:match.range.length];
            pathString = [stringToEncode substringFromIndex:match.range.length];
            
            hostString = [NSURL IDNEncodedURL:hostString];
            
            NSString *queryString = nil;
            NSRange firstMatchAtRange = [pathString rangeOfString:@"?"];
            if (firstMatchAtRange.location != NSNotFound) {
                NSString *pathAndQuery = [NSString stringWithString:pathString];
                pathString = [pathAndQuery substringToIndex:firstMatchAtRange.location];
                queryString = [pathAndQuery substringFromIndex:firstMatchAtRange.location+firstMatchAtRange.length];
            }
            NSString *decodedPathString = [pathString stringByRemovingPercentEncoding:NSUTF8StringEncoding];
            if (!decodedPathString) {
                decodedPathString = [pathString stringByRemovingPercentEncoding:NSWindowsCP1251StringEncoding];
            }
            pathString = [decodedPathString stringByAddingPercentEncodingWithAllowedCharacters:NSUTF8StringEncoding];
            if (queryString) {
                pathString = [NSString stringWithFormat:@"%@?%@", pathString, queryString];
            }
            encodedString = [NSString stringWithFormat:@"%@%@", hostString, pathString];
        } else {
            encodedString = [NSURL IDNEncodedURL:stringToEncode];
        }
        NSRange rangeOfEncodedHash = [encodedString rangeOfString:@"%23" options:NSBackwardsSearch];
        if (rangeOfEncodedHash.location != NSNotFound) {
            encodedString = [encodedString stringByReplacingOccurrencesOfString:@"%23" withString:@"#" options:0 range:rangeOfEncodedHash];
        }
        
        NSURL *URLAfterEncoding = [NSURL URLWithString:encodedString];
        if (URLAfterEncoding) {
            return URLAfterEncoding;
        }
    }
    
    return nil;
}
@end
