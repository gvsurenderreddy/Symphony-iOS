//
//  ReviewsViewController.swift
//  Symphony
//
//  Created by Ang Jian Yao on 22/01/2016.
//  Copyright © 2016 Ang Jian Yao. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController, AddReviewDelegate {
    
    var delegate: AddReviewDelegate?
    var reviews = [String]()
    var emptyLabelInstruction = UILabel()
    
    @IBOutlet weak var reviewsTableView: UITableView! {
        didSet {
            reviewsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
            reviewsTableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reviews"
        createAddReviewButtonOnNavigationItem()
        displayEmptyLabelInstructionWhenReviewsTableEmpty()
    }
    
    func displayEmptyLabelInstructionWhenReviewsTableEmpty() {
        
        if self.reviews.count == 0 {
            
            self.emptyLabelInstruction.frame = self.view.frame
            self.emptyLabelInstruction.center = self.view.center
            self.emptyLabelInstruction.text = "There isn't any reviews yet. \n Feel free to leave a review about this venue"
            self.emptyLabelInstruction.textColor = UIColor.darkTextColor()
            self.emptyLabelInstruction.font = UIFont.systemFontOfSize(16)
            self.emptyLabelInstruction.numberOfLines = 0
            self.emptyLabelInstruction.textAlignment = NSTextAlignment.Center
            
            self.reviewsTableView.addSubview(self.emptyLabelInstruction)
            self.reviewsTableView.bringSubviewToFront(self.emptyLabelInstruction)
        
        }
    }
    
    //MARK: review button
    func createAddReviewButtonOnNavigationItem() {
        
        let reviewBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "onAddReviewButtonPressed")
        self.navigationItem.rightBarButtonItem = reviewBarButton
        
    }
    
    func onAddReviewButtonPressed() {
        self.performSegueWithIdentifier("ToAddReviewVC", sender: nil)
    }
    
    //MARK: segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ToAddReviewVC" {
            
            let addReviewVC = segue.destinationViewController as! AddReviewViewController
            addReviewVC.delegate = self
        }
    }
    
    //MARK: review delegate
    func addReview(review: String) {
        self.reviews.append(review)
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.emptyLabelInstruction.removeFromSuperview()
            self.reviewsTableView.reloadData()
        }
        
    }
}

extension ReviewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let reviewString = self.reviews[indexPath.row]
        
        let reviewCell = tableView.dequeueReusableCellWithIdentifier("ReviewsCellID")! as UITableViewCell
        reviewCell.textLabel?.text = reviewString
    
        return reviewCell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}
