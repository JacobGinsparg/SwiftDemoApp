//
//  MenuController.swift
//  DemoApp
//
//  Created by Jacob Ginsparg on 7/16/15.
//  Copyright (c) 2015 Jacob Ginsparg. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 41, green: 41, blue: 41, alpha: 0.2)
        self.tableView.separatorColor = UIColor.clearColor()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        
        // Set background highlight color for cells
        let highlightColor = UIView()
        highlightColor.backgroundColor = UIColor.blackColor()
        UITableViewCell.appearance().selectedBackgroundView = highlightColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if (indexPath.row == 0) {
        	cell.textLabel!.text = "Home"
            cell.textLabel!.textColor = UIColor(red: 108/255, green: 170/255, blue: 207/255, alpha: 1)
            cell.imageView!.image = UIImage(named: "icHomeBlue.png")
        } else if (indexPath.row == 1) {
            cell.textLabel!.text = "Coupon Hub"
            cell.textLabel!.textColor = UIColor(white: 1, alpha: 1)
            cell.imageView!.image = UIImage(named: "group.png")
        } else if (indexPath.row == 2) {
            cell.textLabel!.text = "Menu Item"
            cell.textLabel!.textColor = UIColor(white: 1, alpha: 0.3)
            cell.imageView!.image = UIImage(named: "ic_track.png")
            cell.imageView!.alpha = 0.2
        } else if (indexPath.row == 3) {
            cell.textLabel!.text = "Menu Item"
            cell.textLabel!.textColor = UIColor(white: 1, alpha: 0.3)
            cell.imageView!.image = UIImage(named: "ic_findPost.png")
            cell.imageView!.alpha = 0.2
        } else if (indexPath.row == 4) {
            cell.textLabel!.text = "Menu Item"
            cell.textLabel!.textColor = UIColor(white: 1, alpha: 0.3)
            cell.imageView!.image = UIImage(named: "ic_findRate.png")
            cell.imageView!.alpha = 0.2
        } else if (indexPath.row == 5) {
            cell.textLabel!.text = "Menu Item"
            cell.textLabel!.textColor = UIColor(white: 1, alpha: 0.3)
            cell.imageView!.image = UIImage(named: "ic_findPostCode.png")
            cell.imageView!.alpha = 0.2
        } else if (indexPath.row == 6) {
            cell.textLabel!.text = "Menu Item"
            cell.textLabel!.textColor = UIColor(white: 1, alpha: 0.3)
            cell.imageView!.image = UIImage(named: "ic_picPost.png")
            cell.imageView!.alpha = 0.2
        } else if (indexPath.row == 7) {
            cell.textLabel!.text = "Menu Item"
            cell.textLabel!.textColor = UIColor(white: 1, alpha: 0.3)
            cell.imageView!.image = UIImage(named: "ic_epost.png")
            cell.imageView!.alpha = 0.2
        } else if (indexPath.row == 8) {
            cell.textLabel!.text = "Menu Item"
            cell.textLabel!.textColor = UIColor(white: 1, alpha: 0.3)
            cell.imageView!.image = UIImage(named: "ic_settings.png")
            cell.imageView!.alpha = 0.2
        } else {
            cell.textLabel!.text = "This shouldn't be here"
        }
        cell.accessoryType = UITableViewCellAccessoryType.DetailButton
        cell.backgroundColor = UIColor(red: 41, green: 41, blue: 41, alpha: 0)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let rvc = self.revealViewController()
        let nav = rvc.frontViewController as! UINavigationController
        if (indexPath.row == 0) {
            rvc.revealToggle(self)
            nav.popViewControllerAnimated(false)
            nav.pushViewController(MainViewController(), animated: false)
        } else if (indexPath.row == 1) {
            rvc.revealToggle(self)
            nav.popViewControllerAnimated(false)
            nav.pushViewController(FeaturedCouponsViewController(), animated: false)
        } else {
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}
