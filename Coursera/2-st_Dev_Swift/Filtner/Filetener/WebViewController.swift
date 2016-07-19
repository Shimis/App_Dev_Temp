//
//  WebViewViewController.swift
//  Filetener
//
//  Created by Alexander Larionov on 14.12.15.
//  Copyright © 2015 Alexander Larionov. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, UITextFieldDelegate {
    
    var webView: WKWebView?
    @IBOutlet weak var omniBox: UITextField!
    
    @IBOutlet weak var WebViewContainer: UIView!
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    
    
    /* Start the network activity indicator when the web view is loading */
    func webView(webView: WKWebView,
        didStartProvisionalNavigation navigation: WKNavigation){
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    /* Stop the network activity indicator when the loading finishes */
    func webView(webView: WKWebView,
        didFinishNavigation navigation: WKNavigation){
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: WKWebView,
        decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse,
        decisionHandler: ((WKNavigationResponsePolicy) -> Void)){
            
            print(navigationResponse.response.MIMEType)
            
            decisionHandler(.Allow)
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.omniBox.delegate = self
        /* Create our preferences on how the web page should be loaded */
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        /* Create a configuration for our preferences */
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.applicationNameForUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Mobile/13B143 LarionovTestBrowser/1.0.0"
        
        
        
        /* Now instantiate the web view */
        webView = WKWebView(frame: self.WebViewContainer.bounds, configuration: configuration)
        webView!.navigationDelegate = self
        webView!.translatesAutoresizingMaskIntoConstraints = false
        webView!.allowsBackForwardNavigationGestures = true
            
        self.WebViewContainer.addSubview(webView!)
        
        let viewsDictionary = [
            "webView":self.webView!
            ]
        
        
        let hconstrains = NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: viewsDictionary)
        
        let vconstrains =  NSLayoutConstraint.constraintsWithVisualFormat("V:|[webView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        
        
        self.WebViewContainer.addConstraints(hconstrains)
        self.WebViewContainer.addConstraints(vconstrains)
        
        
        
        
        
        
        
        
        
        
        
        /* Load a web page into our web view */
            let url = NSURL(string: "http://www.sputnik.ru")
            let urlRequest = NSURLRequest(URL: url!)
            webView!.loadRequest(urlRequest)
        
        
        
        
    }
    
    
    
    @IBAction func returnAction(sender: AnyObject) {
        self.urlProcessed()
        
    }
    @IBAction func goAction(sender: AnyObject) {
        omniBox.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func urlProcessed (){
        let urlstring = omniBox.text
        let url = urlEncode(urlstring)
        let urlRequest = NSURLRequest(URL: url!)
        self.webView!.loadRequest(urlRequest)
        
    }
    
    
}