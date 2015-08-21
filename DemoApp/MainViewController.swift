//
//  MainViewController.swift
//  DemoApp
//
//  Created by Jacob Ginsparg on 7/17/15.
//  Copyright (c) 2015 Jacob Ginsparg. All rights reserved.
//

import UIKit

class MainViewController: MenuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Glorious Demo App"
        
        let initialImage = UIImage(named: "firstScreen.png")
        let initialView = UIImageView(image: initialImage)
        initialView.userInteractionEnabled = true
        initialView.contentMode = .ScaleAspectFit
        
        self.view.addSubview(initialView)
        self.view.contentMode = .ScaleAspectFit
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}