//
//  ViewController.swift
//  Symphony
//
//  Created by Ang Jian Yao on 22/01/2016.
//  Copyright © 2016 Ang Jian Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var liveMusicTableView: UITableView! {
        didSet {
            liveMusicTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
    }
    
    var symphony = [Symphony]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Symphony"
        
        retrieveLiveMusicEvents()
    }
    
    func retrieveLiveMusicEvents() {
        
        let eventAPIController = EventAPIController(delegate: self)
        eventAPIController.retrieveEvents()
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ToDetailsVC" {
            
            let selectedIndexPath = self.liveMusicTableView.indexPathForSelectedRow
            let selectedSymphony = self.symphony[(selectedIndexPath?.row)!]
            
            let detailsVC = segue.destinationViewController as! DetailsViewController
            detailsVC.symphony = selectedSymphony

        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symphony.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let symphony = self.symphony[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LiveMusicCellID")! as UITableViewCell
    
        cell.textLabel?.text = symphony.eventName
        
        let backgroundImageData = NSData(contentsOfURL: NSURL(string: symphony.imageOfVenue)!)
        let backgroundImage = UIImage(data: backgroundImageData!)
        cell.backgroundView = UIImageView(image: backgroundImage)
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.textLabel?.font = UIFont.systemFontOfSize(30)
        
        let darkOverlayBackgroundView = UIView(frame: cell.bounds)
        darkOverlayBackgroundView.backgroundColor = UIColor.blackColor()
        darkOverlayBackgroundView.alpha = 0.5
        
        cell.backgroundView?.addSubview(darkOverlayBackgroundView)
        cell.backgroundView?.contentMode = UIViewContentMode.ScaleAspectFill
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.performSegueWithIdentifier("ToDetailsVC", sender: nil)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 210
    }
}

extension ViewController: EventAPIControllerDelegate {
    
    func didReceiveConnectionErrorRetrievingEvents(connectionError: NSError) {
        
        print("connectionErrorVC when retrieve live music events \(connectionError)")
        
    }
    
    func didRetrieveEvents(liveMusicEvent: NSDictionary) {
        
        let data = liveMusicEvent.objectForKey("data") as! NSArray
        
        for symphonyData in data {
            
            print(symphonyData.objectForKey("attributes"))
            
            var liveMusic = Symphony()
            liveMusic.eventName = symphonyData.valueForKeyPath("attributes.name") as! String
            liveMusic.imageOfVenue = symphonyData.valueForKeyPath("attributes.image-url")as! String
            liveMusic.address = symphonyData.valueForKeyPath("attributes.address") as! String
            liveMusic.details = symphonyData.valueForKeyPath("attributes.details") as! String
            liveMusic.phone = symphonyData.valueForKeyPath("attributes.phone") as! String
            
            self.symphony.append(liveMusic)
        }
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.liveMusicTableView.reloadData()
        }
        
    }
}


