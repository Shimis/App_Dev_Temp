//
//  Feed.swift
//  PhotoFeed
//
//  Created by Mike Spears on 2016-01-08.
//  Copyright © 2016 YourOganisation. All rights reserved.
//

import Foundation



func fixJsonData (data: NSData) -> NSData {
    var dataString = String(data: data, encoding: NSUTF8StringEncoding)!
    dataString = dataString.stringByReplacingOccurrencesOfString("\\'", withString: "'")
    return dataString.dataUsingEncoding(NSUTF8StringEncoding)!
    
}


class Feed {
    
    let items: [FeedItem]
    let sourceURL: NSURL
    
    init (items newItems: [FeedItem], sourceURL newURL: NSURL) {
        self.items = newItems
        self.sourceURL = newURL
    }
    
}