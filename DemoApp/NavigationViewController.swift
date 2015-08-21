//
//  NavigationViewController.swift
//  DemoApp
//
//  Created by Jacob Ginsparg on 7/17/15.
//  Copyright (c) 2015 Jacob Ginsparg. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    var showMyCoupons = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pushViewController(MainViewController(), animated: true) // This is what it should be when we're done
        //self.pushViewController(FeaturedCouponsViewController(), animated: true) // doing this for now to save time
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
