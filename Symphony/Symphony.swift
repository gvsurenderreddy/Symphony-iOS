//
//  Symphony.swift
//  Symphony
//
//  Created by Ang Jian Yao on 22/01/2016.
//  Copyright © 2016 Ang Jian Yao. All rights reserved.
//

import Foundation

struct Symphony {
    
    var eventName: String
    var venueDescription: String
    var reviews: [String]
    var imageOfVenue: String
    
    init() {
        eventName = ""
        venueDescription = ""
        reviews = [""]
        imageOfVenue = ""
    }
    
}