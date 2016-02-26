//
//  FeaturedCouponsViewController.swift
//  DemoApp
//
//  Created by Jacob Ginsparg on 7/17/15.
//  Copyright (c) 2015 Jacob Ginsparg. All rights reserved.
//

import UIKit

class FeaturedCouponsViewController: MenuViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Vars
    
    let offWhite = UIColor(white: 0, alpha: 0.05)
    let mainFrame = UIScreen.mainScreen().applicationFrame
    var showMyCoupons = false
    let tableView = UITableView(frame: CGRectInset(UIScreen.mainScreen().applicationFrame, 8, 90), style: UITableViewStyle.Grouped)
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Featured Coupons"
        self.edgesForExtendedLayout = UIRectEdge.None // Bounds the view by the nav, instead of the top of the screen
        self.view.backgroundColor = offWhite
        let navHeight = (self.revealViewController().frontViewController as! UINavigationController).navigationBar.frame.height
        
        // Create the scan button
        let scanButton = UIButton()
        let buttonImage = UIImage(named: "btnLargeBlue.png")
        scanButton.setImage(buttonImage, forState: UIControlState.Normal)
        scanButton.frame.size = buttonImage!.size
        scanButton.center.x = mainFrame.width/2
        scanButton.center.y = mainFrame.height - 30 - scanButton.frame.height/2 - navHeight
        scanButton.addTarget(self, action: "showCamera:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Create table
        tableView.center.x = mainFrame.width/2
        tableView.center.y = 16.5 + tableView.frame.height/2
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = UIColor.clearColor()
        
        // Add button and table
        self.view.addSubview(tableView)
        self.view.addSubview(scanButton)
        
        // Right bar button
        let searchButton = UIBarButtonItem(image: UIImage(named: "importedLayers.png"), style: UIBarButtonItemStyle.Plain, target: self, action: "toggleCoupons:")
        self.navigationItem.rightBarButtonItem = searchButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if ((self.navigationController as! NavigationViewController).showMyCoupons) {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Featured"
        } else if (section == 1) {
            return "My Coupons"
        } else {
            return "This section shouldn't be here"
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        var normalImage : String
        var selectedImage : String
        if (indexPath.section == 0 && indexPath.row == 0) {
            normalImage = "michaelCoupon.png"
            selectedImage = "michaelCouponDark.png"
        } else if (indexPath.section == 0 && indexPath.row == 1) {
            normalImage = "bulkBarnCoupon.png"
            selectedImage = "bulkBarnCouponDark.png"
        } else if (indexPath.section == 1 && indexPath.row == 0) {
            normalImage = "tireCoupon.png"
            selectedImage = "canadaTireDark.png"
        } else {
            normalImage = "ERROR"
            selectedImage = "ERROR"
        }
        cell.backgroundView = UIImageView(image: UIImage(named: normalImage))
        cell.selectedBackgroundView = UIImageView(image: UIImage(named: selectedImage))
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let nav = self.revealViewController().frontViewController as! UINavigationController
        if (indexPath.section == 0 && indexPath.row == 0) {
        	nav.pushViewController(DetailViewController(), animated: true)
        } else if (indexPath.section == 1 && indexPath.row == 0) {
            nav.pushViewController(TireViewController(), animated: true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: Button functions
    
    func showCamera(sender: UIButton!) {
        let nav = self.revealViewController().frontViewController as! UINavigationController
        nav.pushViewController(CameraViewController(), animated: true)
    }
    
    func toggleCoupons(sender: UIButton!) {
        (self.navigationController as! NavigationViewController).showMyCoupons = !(self.navigationController as! NavigationViewController).showMyCoupons
		tableView.reloadData()
    }
}