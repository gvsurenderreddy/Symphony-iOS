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
        
        createTestSymphony()
        
    }
    
    
    func createTestSymphony() {
        
        var symphony1 = Symphony()
        symphony1.eventName = "Merdekarya"

        var symphony2 = Symphony()
        symphony2.eventName = "Hello"
        
        
        self.symphony = [symphony1, symphony2]
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ToDetailsVC" {
            
            let selectedIndexPath = self.liveMusicTableView.indexPathForSelectedRow
            let selectedSymphony = self.symphony[(selectedIndexPath?.row)!]
            
            let detailsVC = segue.destinationViewController as! DetailsViewController
            detailsVC.symphony = selectedSymphony
            print("\(detailsVC.symphony!.eventName)")

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
        cell.backgroundView = UIImageView(image: UIImage(named: "kylo"))
        
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
        darkOverlayBackgroundView.alpha = 0.6
        
        cell.backgroundView?.addSubview(darkOverlayBackgroundView)
        cell.backgroundView?.contentMode = UIViewContentMode.ScaleAspectFill
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.performSegueWithIdentifier("ToDetailsVC", sender: nil)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }
}


