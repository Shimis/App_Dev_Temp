//
//  ViewController.swift
//  PhotoFeed
//
//  Created by Mike Spears on 2016-01-07.
//  Copyright © 2016 YourOganisation. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDateLabel()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateDateLabel(){
        let lastUpadte = NSUserDefaults.standardUserDefaults().objectForKey("buttonTapped") as? String
        
        if let hasUpdated = lastUpadte {
            self.dateLabel.text = hasUpdated
        } else {
            self.dateLabel.text = "No data saved."
        }
    }

    @IBAction func updateButtonAction(sender: AnyObject) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm:ss "
        let now = formatter.stringFromDate(NSDate())
        
        print(now)
        NSUserDefaults.standardUserDefaults().setObject(now, forKey: "buttonTapped")
        self.updateDateLabel()
    }
    
    
    
}

