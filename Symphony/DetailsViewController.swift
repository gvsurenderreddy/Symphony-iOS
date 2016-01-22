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
        
        self.title = self.symphony?.eventName
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
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.textLabel?.text = self.symphony!.eventName
            
            return cell
            
        } else if indexPath.row == 1 {
            
            let secondCell = tableView.dequeueReusableCellWithIdentifier("DetailsSecondCellID")!
            secondCell.textLabel?.text = "Description"
            secondCell.textLabel?.font = UIFont.systemFontOfSize(20)
            secondCell.textLabel?.numberOfLines = 0
            secondCell.selectionStyle = UITableViewCellSelectionStyle.None
            
            secondCell.detailTextLabel?.text = "Second cell detail text label lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum abc"
            secondCell.detailTextLabel?.numberOfLines = 0
            secondCell.detailTextLabel?.font = UIFont.systemFontOfSize(14)
            return secondCell
            
        } else {

            let thirdCell = tableView.dequeueReusableCellWithIdentifier("DetailsThirdCellID")!
            thirdCell.textLabel?.text = "Reviews"
            thirdCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            thirdCell.selectionStyle = UITableViewCellSelectionStyle.None
            return thirdCell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 120
        } else if indexPath.row == 1 {
            return 180
        } else {
            return 50
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 2 {
            self.performSegueWithIdentifier("ToReviewsVC", sender: nil)
        }
    }
    

}