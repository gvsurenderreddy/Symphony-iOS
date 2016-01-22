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
        
        let urlString = "https://mysterious-spire-77202.herokuapp.com/api/venues"
        let url = NSURL(string: urlString)
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "GET"
        urlRequest.setValue("application/vnd.api+json", forHTTPHeaderField: "Accept")
        
        let urlSession = NSURLSession.sharedSession()

        let urlSessionTask = urlSession.dataTaskWithRequest(urlRequest, completionHandler: { (data, urlResponse, urlSessionError) -> Void in
                
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
