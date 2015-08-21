//
//  ViewController.swift
//  DemoApp
//
//  Created by Jacob Ginsparg on 7/17/15.
//  Copyright (c) 2015 Jacob Ginsparg. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sidebarButton = UIBarButtonItem(image: UIImage(named: "icHamburger.png"), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = sidebarButton
        
        if let rvc = self.revealViewController() {
            sidebarButton.target = self.revealViewController()
            sidebarButton.action = "revealToggle:"
            self.view.addGestureRecognizer(rvc.panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}