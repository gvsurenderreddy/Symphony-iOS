//
//  EventAPIController.swift
//  Symphony
//
//  Created by Ang Jian Yao on 22/01/2016.
//  Copyright © 2016 Ang Jian Yao. All rights reserved.
//

import UIKit

protocol EventAPIControllerDelegate {
    
    func didRetrieveEvents(liveMusicEvent: NSDictionary)
    func didReceiveConnectionErrorRetrievingEvents(connectionError:NSError)
    
}

class EventAPIController: NSObject {

    var eventAPIDelegate: EventAPIControllerDelegate
    
    init(delegate: EventAPIControllerDelegate) {
        self.eventAPIDelegate = delegate
    }
    
    func retrieveEvents() {
        
        let urlString = ""
        let url = NSURL(string: urlString)
        let urlSession = NSURLSession.sharedSession()
        
        if let validURL = url {
            let urlSessionTask = urlSession.dataTaskWithURL(validURL, completionHandler: { (data, urlResponse, urlSessionError) -> Void in
                
                if urlSessionError != nil {
                    
                    if let connectionError = urlSessionError {
                        self.eventAPIDelegate.didReceiveConnectionErrorRetrievingEvents(connectionError)
                    }
                
                } else {
                    
                    do {
                        
                        if let liveMusicEventData = data {
                            let liveMusicEvent = try NSJSONSerialization.JSONObjectWithData(liveMusicEventData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                            self.eventAPIDelegate.didRetrieveEvents(liveMusicEvent)
                        }

                    } catch {
                        print("urlSessionError \(urlSessionError)")
                    }
                }
            })
            urlSessionTask.resume()
        }
    }
}
