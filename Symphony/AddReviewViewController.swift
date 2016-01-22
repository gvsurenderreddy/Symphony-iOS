//
//  AddReviewViewController.swift
//  Symphony
//
//  Created by Ang Jian Yao on 22/01/2016.
//  Copyright © 2016 Ang Jian Yao. All rights reserved.
//

import UIKit

protocol AddReviewDelegate {
    func addReview(review: String)
}

class AddReviewViewController: UIViewController {
    
    var delegate: AddReviewDelegate?

    @IBOutlet weak var dismissButton: UIButton! {
        didSet {
            dismissButton.setTitle("X", forState: UIControlState.Normal)
        }
    }
    
    @IBOutlet weak var doneButton: UIButton! {
        didSet {
            doneButton.setTitle("Add", forState: UIControlState.Normal)
        }
    }
    
    @IBOutlet weak var reviewTextView: UITextView! {
        didSet {
            reviewTextView.text = "Please type your review here"
            reviewTextView.delegate = self
            reviewTextView.textColor = UIColor.lightGrayColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    //MARK: Done Button
    @IBAction func onDoneButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.delegate?.addReview(self.reviewTextView.text)
    }

    //MARK: Dismiss button
    @IBAction func onDismissButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension AddReviewViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        if textView.text == "Please type your review here" {
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        if textView.text == "" {
            textView.text = "Please type your review here"
            textView.textColor = UIColor.lightGrayColor()
        }
        textView.resignFirstResponder()
    }
    
}
