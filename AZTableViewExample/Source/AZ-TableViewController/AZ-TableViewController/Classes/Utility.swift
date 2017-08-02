//
//  Utility.swift
//  AZ-TableViewController
//
//  Created by Muhammad Afroz on 7/31/17.
//  Copyright © 2017 AfrozZaheer. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    static func getBundle() -> Bundle {
        
        let podBundle = Bundle(for: AZTableViewController.self)
        
        let bundleURL = podBundle.url(forResource: "AZTableViewElements", withExtension: "bundle")
        return Bundle(url: bundleURL!)!
    }
}
