//
//  ReviewsViewController.swift
//  Symphony
//
//  Created by Ang Jian Yao on 22/01/2016.
//  Copyright © 2016 Ang Jian Yao. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

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
}
