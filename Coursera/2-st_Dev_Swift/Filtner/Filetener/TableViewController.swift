//
//  TableViewController.swift
//  Filetener
//
//  Created by Alexander Larionov on 23.11.15.
//  Copyright © 2015 Alexander Larionov. All rights reserved.
//

import UIKit




class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let transitionRight : CATransition = CATransition()
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let filters = [
        "Filtener",
        "Web view"
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let ip : NSIndexPath? = self.tableView!.indexPathForSelectedRow
        
        if ip != nil {
            
            self.tableView!.deselectRowAtIndexPath(ip!, animated: true)
       
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        switch filters[indexPath.row]{
           
        case "Filtener" :
                self.performSegueWithIdentifier("toFiltner", sender: self)
        case "Web view" :
                self.performSegueWithIdentifier("toWebView", sender: self)
        default :
                self.performSegueWithIdentifier("toFiltner", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FilterCell", forIndexPath: indexPath)
        cell.textLabel?.text = filters[indexPath.row]
        cell.backgroundColor = UIColor(red: 74/255.0, green: 74/255.0, blue: 74/255.0, alpha: 1)
        
        switch filters[indexPath.row]{
            
        case "Filtener" :
            cell.detailTextLabel?.text = "Create buitifull filtered picture"
        case "Web view" :
            cell.detailTextLabel?.text = "Working with WKWebView"
        default :
            cell.detailTextLabel?.text = "Other Actions"
        }
        
        
        return cell
    }
    
    
    


}