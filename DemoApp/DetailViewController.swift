//
//  DetailViewController.swift
//  DemoApp
//
//  Created by Jacob Ginsparg on 7/20/15.
//  Copyright (c) 2015 Jacob Ginsparg. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "40% off"
        self.edgesForExtendedLayout = UIRectEdge.None // Bounds the view by the nav, instead of the top of the screen
        let mainFrame = UIScreen.mainScreen().bounds
        
        let mrView = UIScrollView(frame: self.view.frame)
        mrView.contentSize = CGSize(width: mainFrame.width, height: 780)
        mrView.backgroundColor = UIColor.whiteColor()
        
        // Cover
        let cover = UIImageView(image: UIImage(named: "cover.png"))
        mrView.addSubview(cover)
        
        // Expiration
        let expiration = UIImageView(image: UIImage(named: "expiration.png"))
        expiration.frame.origin.y = 158
        mrView.addSubview(expiration)
        
        // Coupon info
        let couponInfo = UIImageView(image: UIImage(named: "bgHeadlineCopy.png"))
        couponInfo.frame.origin.y = 192.5
        mrView.addSubview(couponInfo)

        // Redeem button
        let redeemButton = UIButton()
        let redeemImage = UIImage(named: "btnRedeem.png")
        redeemButton.setImage(redeemImage, forState: UIControlState.Normal)
        redeemButton.frame.size = redeemImage!.size
        redeemButton.frame.origin.y = 284.5
        redeemButton.center.x = mainFrame.width/2
        redeemButton.addTarget(self, action: "showRedeem:", forControlEvents: UIControlEvents.TouchUpInside)
        mrView.addSubview(redeemButton)
        
        // View original
        let viewOriginal = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        viewOriginal.text = "View original coupon image"
        viewOriginal.textColor = UIColor(red: 0, green: 122/255, blue: 195/255, alpha: 1)
        viewOriginal.textAlignment = NSTextAlignment.Center
        viewOriginal.font = UIFont(name: "GillSans-Bold", size: 14)
        viewOriginal.center.x = mainFrame.width/2
        viewOriginal.frame.origin.y = 352
        mrView.addSubview(viewOriginal)
        
        // Details
        let details = UIImageView(image: UIImage(named: "theFinePrint.png"))
        details.frame.origin.y = 403.5
        mrView.addSubview(details)
        
        // Action button
        let shareButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: nil, action: nil)
		self.navigationItem.rightBarButtonItem = shareButton
        
        self.view = mrView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showRedeem(sender: UIButton!) {
        let barcode = UIImageView(image: UIImage(named: "barcode.png"))
        barcode.frame.origin.y = 284.5
        barcode.center.x = UIScreen.mainScreen().bounds.width/2
        self.view.addSubview(barcode)

        let viewOriginal = self.view.subviews[4] as! UILabel
        let details = self.view.subviews[5] as! UIImageView
        
    	viewOriginal.frame.origin.y = 484.5
        details.frame.origin.y = 529
        (self.view as! UIScrollView).contentSize.height = 905
    }
    
}
