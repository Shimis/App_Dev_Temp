//
//  URLHelper.swift
//  Filetener
//
//  Created by Alexander Larionov on 16.12.15.
//  Copyright © 2015 Alexander Larionov. All rights reserved.
//

import Foundation

extension String {
    func isURL() throws -> Bool {
        let url_pattern = "https?://[^/]+.+[.]+."
        let regex = try NSRegularExpression(pattern: url_pattern, options: [.CaseInsensitive])
        
        return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count)) != nil
    }
    func haveHttp() throws -> Bool{
        let httpExp = "(?i)https?://"
        let regex = try NSRegularExpression(pattern: httpExp, options: [.CaseInsensitive])
        
        
        return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count)) != nil
        
    }
}

public func urlEncode (url:String?) -> NSURL?{
    let customAllowedSet = NSCharacterSet(charactersInString:"\"#%<>@\\^`{|}").invertedSet
    let queryAllowedSet = NSCharacterSet.URLQueryAllowedCharacterSet()
    var userQuery = url!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    let isURL : Bool
    let haveHTTP : Bool
    var encodedURL : NSURL
    
    // Check to HTTP
    do {
        haveHTTP = try userQuery.haveHttp()
    }catch{
        print(error)
        return nil
    }
    
    if haveHTTP {
       
        // Check for URL
        do{
            isURL = try userQuery.isURL()
        }catch{
            print(error)
            return nil
        }
        
        
        if isURL {
            encodedURL = NSURL(string: userQuery.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!)!
            return encodedURL
            
        }
    }else{
        
        userQuery = "http://" + userQuery
        // Check for URL
        do{
            isURL = try userQuery.isURL()
        }catch{
            print(error)
            return nil
        }
        
        
        if isURL {
            encodedURL = NSURL(string: userQuery.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!)!
            return encodedURL
            
        }

        
    }
    let searchstring = "http://www.sputnik.ru/search?q=" + url!.stringByAddingPercentEncodingWithAllowedCharacters(queryAllowedSet)!
    encodedURL = NSURL(string: searchstring)!
    return encodedURL
    
}