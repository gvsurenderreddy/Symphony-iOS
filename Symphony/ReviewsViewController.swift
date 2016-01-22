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
    
    @IBOutlet weak var reviewsTableView: UITableView! {
        didSet {
            reviewsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reviews"
        createAddreviewButtonOnNavigationItem()
    }
    
    //MARK: review button
    func createAddreviewButtonOnNavigationItem() {
        
        let reviewBarButton = UIBarButtonItem(title: "+", style: .Plain, target: self, action: "onAddReviewButtonPressed")
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
}
