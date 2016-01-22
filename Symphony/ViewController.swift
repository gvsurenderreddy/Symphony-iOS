//
//  ViewController.swift
//  Symphony
//
//  Created by Ang Jian Yao on 22/01/2016.
//  Copyright © 2016 Ang Jian Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var liveMusicTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LiveMusicCellID")! as UITableViewCell
        
        cell.textLabel?.text = "Hello"
        
        return cell
        
        
    }
}


