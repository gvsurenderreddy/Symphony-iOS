//
//  DetailsViewController.swift
//  Symphony
//
//  Created by Ang Jian Yao on 22/01/2016.
//  Copyright © 2016 Ang Jian Yao. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var symphony: Symphony?

    @IBOutlet weak var detailsTableView: UITableView! {
        didSet {
            detailsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details"

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ToReviewsVC" {
            _ = ReviewsViewController()
        }
        
    }
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailsFirstCellID")!
            cell.textLabel?.text = self.symphony!.eventName
            
            return cell
        } else if indexPath.row == 1 {
            
            let secondCell = tableView.dequeueReusableCellWithIdentifier("DetailsSecondCellID")!
            secondCell.textLabel?.text = "Second Cell"
            secondCell.detailTextLabel?.text = "Second cell detail text label"
            return secondCell
            
        } else {

            let thirdCell = tableView.dequeueReusableCellWithIdentifier("DetailsThirdCellID")!
            thirdCell.textLabel?.text = "Reviews"
            thirdCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return thirdCell
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 2 {
            self.performSegueWithIdentifier("ToReviewsVC", sender: nil)
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 100
        } else if indexPath.row == 1 {
            return 100
        } else {
            return 50
            
        }
    }
}