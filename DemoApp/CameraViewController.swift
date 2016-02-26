//
//  CameraViewController.swift
//  DemoApp
//
//  Created by Jacob Ginsparg on 7/22/15.
//  Copyright (c) 2015 Jacob Ginsparg. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let dimBackground = UIView()
    var viewPresent = true
    var animatingSnap = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None // Bounds the view by the nav, instead of the top of the screen
        self.view.backgroundColor = UIColor.whiteColor()
        
        // Finds the back camera
        let devices = AVCaptureDevice.devices()
        for device in devices {
            if (device.hasMediaType(AVMediaTypeVideo) && device.position == AVCaptureDevicePosition.Back) {
                captureDevice = device as? AVCaptureDevice
            }
        }
        
        // Starts the camera session
        if captureDevice != nil {
            startCameraSession()
        }
        
        // Add dim background
        self.view.addSubview(dimBackground)
        
        // Add shutter bar
        let shutterBar = UIView(frame: CGRect(x: 0, y: UIScreen.mainScreen().bounds.height-195, width: screenWidth, height: 133.5))
        shutterBar.backgroundColor = UIColor.blackColor()
        self.view.addSubview(shutterBar)
        
        // Add shutter button
        let shutterButton = UIButton()
        let shutterImage = UIImage(named: "btnShutter.png")
        shutterButton.setImage(shutterImage, forState: UIControlState.Normal)
        shutterButton.frame.size = shutterImage!.size
        shutterButton.center.x = screenWidth/2
        shutterButton.frame.origin.y = 21
        shutterButton.addTarget(self, action: "couponAnimation:", forControlEvents: UIControlEvents.TouchUpInside)
        shutterBar.addSubview(shutterButton)
        
        // Add X button
        let xButton = UIBarButtonItem(image: UIImage(named: "icClose"), style: UIBarButtonItemStyle.Plain, target: self, action: "popSelf:")
        xButton.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = xButton
        
        // Add right bar toggle button
        let toggleAnimationButton = UIBarButtonItem(title: "Snap", style: UIBarButtonItemStyle.Plain, target: self, action: "toggleSnapDetect:")
        toggleAnimationButton.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = toggleAnimationButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Camera functions
    
    func startCameraSession() {
        configureDevice()
        do {
            try self.captureSession.addInput(AVCaptureDeviceInput(device: self.captureDevice))
        } catch let err as NSError {
            print("error: \(err.localizedDescription)")
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
    }
    
    func configureDevice() {
        do {
            if let device = captureDevice {
                try device.lockForConfiguration()
                device.focusMode = .Locked
                device.unlockForConfiguration()
            }
        } catch { }
    }
    
    func focusTo(value : Float) {
        do {
            if let device = captureDevice {
                try device.lockForConfiguration()
                device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
                    //
                })
                device.unlockForConfiguration()
            }
        } catch { }
    }

    // MARK: Controller overrides
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let anyTouch = touches.first!
        let touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let anyTouch = touches.first!
        let touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let navBar = (self.revealViewController().frontViewController as! UINavigationController).navigationBar
        navBar.barTintColor = UIColor.blackColor()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let navBar = (self.revealViewController().frontViewController as! UINavigationController).navigationBar
		navBar.barTintColor = UIColor.whiteColor()
        viewPresent = false
    }
    
    // MARK: Button and animation functions
    
    func popSelf(sender: UIButton!) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func couponAnimation(sender: UIButton!) {
        // Remove all subviews
        let _ = self.view.subviews.map({ ($0).subviews.map({ $0.removeFromSuperview() }) })
        
        // This stops the camera
        if (captureDevice != nil) {
            captureSession.stopRunning()
        }
        
        
        // Configure animation
        var animationImages = [UIImage]()
        let numberOfImages = animatingSnap ? 311 : 117
        for counter in 0...numberOfImages {
            let snapImageName : String
            if animatingSnap {
                snapImageName = String(format: "cp_snap_1b_00%03d.png", counter)
            } else {
                snapImageName = String(format: "cp_detect_1c_00%03d.png", counter)
            }
            let snapImage = UIImage(named: snapImageName)
            animationImages.append(snapImage!)
        }
        let animationDuration = animatingSnap ? 15 : 4
        let nav = self.revealViewController().frontViewController as! NavigationViewController
        let navHeight = nav.navigationBar.frame.height
        let overlay = UIImageView(image: UIImage(contentsOfFile: "bgTestAnimation.png"))
        let animator = UIImageView()
        animator.frame = CGRect(x: 0, y: -navHeight, width: overlay.frame.width, height: overlay.frame.height)
        
        // Configure dim background
        dimBackground.frame = animator.frame
        dimBackground.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        // Start animation
        self.view.addSubview(animator)
        animator.addSubview(UIImageView(image: UIImage.animatedImageWithImages(animationImages, duration: NSTimeInterval(animationDuration))))
		NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(animationDuration), target: self, selector: "doneAnimating:", userInfo: nil, repeats: false)
    }
    
    func doneAnimating(sender: AnyObject!) {
        if (viewPresent) {
            // Remove animation
            let _ = self.view.subviews.map({ ($0).subviews.map({ $0.removeFromSuperview() }) })
            
            // Keep last image
            let nav = self.revealViewController().frontViewController as! NavigationViewController
            let navHeight = nav.navigationBar.frame.height
            let lastStill : UIImageView
            if animatingSnap {
                lastStill = UIImageView(image: UIImage(named: "cp_snap_1b_00311.png"))
            } else {
                lastStill = UIImageView(image: UIImage(named: "cp_detect_1c_00117.png"))
            }
            lastStill.frame.origin.y = -navHeight
            self.view.addSubview(lastStill)
            
            // Add button to head back
            let backButton = UIButton()
            let backButtonImage = UIImage(named: "tireButton.png")
            let backButtonImagePressed = UIImage(named: "tireButtonPressed.png")
            if animatingSnap {
                backButton.frame = CGRect(x: 75, y: 221-navHeight, width: 225, height: 225)
                backButton.center.x = screenWidth/2
                backButton.addTarget(self, action: "backToCoupons:", forControlEvents: UIControlEvents.TouchUpInside)
            } else {
                backButton.setImage(backButtonImage, forState: UIControlState.Normal)
                backButton.setImage(backButtonImagePressed, forState: UIControlState.Highlighted)
                backButton.frame.size = backButtonImage!.size
                backButton.center.x = screenWidth/2
                backButton.frame.origin.y = 266-navHeight
                backButton.addTarget(self, action: "backToCoupons:", forControlEvents: UIControlEvents.TouchUpInside)
            }
            self.view.addSubview(backButton)
        }
    }
    
    func backToCoupons(sender: UIButton!) {
        // Toggle coupons
        let nav = self.revealViewController().frontViewController as! NavigationViewController
        for vc in nav.viewControllers {
            if (vc is FeaturedCouponsViewController) {
                nav.showMyCoupons = true
                (vc as! FeaturedCouponsViewController).tableView.reloadData()
            }
        }
        
        // Pop back to featured list
        nav.popViewControllerAnimated(true)
    }
    
    func toggleSnapDetect(sender: UIBarButtonItem!) {
        animatingSnap = !animatingSnap
        if sender.title == "Snap" {
            sender.title = "Detect"
        } else {
            sender.title = "Snap"
        }
    }
    
}
