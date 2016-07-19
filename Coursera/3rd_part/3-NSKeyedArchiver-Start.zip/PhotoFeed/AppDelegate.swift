//
//  AppDelegate.swift
//  PhotoFeed
//
//  Created by Mike Spears on 2016-01-07.
//  Copyright © 2016 YourOganisation. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NSUserDefaults.standardUserDefaults().registerDefaults(["PhotoFeedURLString": "https://api.flickr.com/services/feeds/photos_public.gne?tags=kitten&format=json&nojsoncallback=1"])
        return true
    }


    func applicationDidBecomeActive(application: UIApplication) {
        let urlString = NSUserDefaults.standardUserDefaults().stringForKey("PhotoFeedURLString")
        print(urlString)
        
        
        guard let foundURLString = urlString else {
            return
        }
        
        if let url = NSURL(string: foundURLString) {
            self.updateFeed(url, completion: { (feed) -> Void in
                let viewController = application.windows[0].rootViewController as? ImageFeedTableViewController
                viewController?.feed = feed
            })
        }
    }
    

    func updateFeed(url: NSURL, completion: (feed: Feed?) -> Void) {
        let request = NSURLRequest(URL: url)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error == nil && data != nil {
                let feed = Feed(data: data!, sourceURL: url)
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completion(feed: feed)
                })
            }

        }
        
        task.resume()
    }

    

}

