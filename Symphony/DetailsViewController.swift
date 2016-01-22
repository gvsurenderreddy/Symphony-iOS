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
            detailsTableView.tableFooterView = UIView()
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
        
        let cell: UITableViewCell!
    
        if indexPath.row == 0 {
            
            cell = tableView.dequeueReusableCellWithIdentifier("DetailsFirstCellID")!
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.textLabel?.text = self.symphony!.eventName
            cell.textLabel?.font = UIFont.systemFontOfSize(20)
            
            cell.detailTextLabel?.text = "Address: \(self.symphony!.address) \n\nPhone: \(self.symphony!.phone)"
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(16)
            
            return cell
            
        } else if indexPath.row == 1 {
            
            cell = tableView.dequeueReusableCellWithIdentifier("DetailsSecondCellID")!
            cell.textLabel?.text = "Description"
            cell.textLabel?.font = UIFont.systemFontOfSize(20)
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.detailTextLabel?.text = "Summary: \(self.symphony!.details)"
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(16)
            return cell
            
        } else {

            cell = tableView.dequeueReusableCellWithIdentifier("DetailsThirdCellID")!
            cell.textLabel?.text = "Reviews"
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 120
        } else if indexPath.row == 1 {
            return 80
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