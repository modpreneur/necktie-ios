//
//  IntroViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 18/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import SwiftyUserDefaults

class IntroViewController: UIViewController, CAAnimationDelegate {
    
    private var loadingMask: CALayer?
    private var windowColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()

        if Defaults[.introAnimation] == false {
            let color: UIColor = UIColor().necktiePrimary
            let maskImage: UIImage = UIImage.init(named: "Logo_Mask")!
            loadingAnimationMaskCreate(transparent: true, backgroundColor: color, maskImage: maskImage)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if Defaults[.introAnimation] == false {
            animateLoadingMask()
            Defaults[.introAnimation] = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - CAAnimationDelegate
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if self.loadingMask != nil {
            self.view.layer.mask = nil
            self.loadingMask?.superlayer?.removeFromSuperlayer()
            self.loadingMask = nil
        }
    }
    
    // MARK: - Private methods
    
    private func loadingAnimationMaskCreate(transparent: Bool, backgroundColor: UIColor, maskImage: UIImage) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let maskSize: CGSize = CGSize(width: 120, height: 125)
        
        self.windowColor = appDelegate.window?.backgroundColor
        appDelegate.window!.backgroundColor = backgroundColor
        
        let screenBounds = UIScreen.main.bounds
        
        let mask = CALayer()
        mask.contents = maskImage.cgImage
        mask.contentsGravity = kCAGravityResizeAspect
        mask.bounds = CGRect(x: 0, y: 0, width: maskSize.width, height: maskSize.height)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mask.position = CGPoint(x: screenBounds.width/2, y: screenBounds.height/2)
        self.loadingMask = mask
        
        if transparent {
            self.view.layer.mask = mask
        } else {
            let backgroundMask = CALayer()
            backgroundMask.frame = self.view.frame
            backgroundMask.backgroundColor = backgroundColor.cgColor
            self.view.layer.addSublayer(backgroundMask)
            backgroundMask.addSublayer(mask)
        }
    }
    
    private func animateLoadingMask() {
        if self.loadingMask != nil {
            let keyFrameAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
            keyFrameAnimation.delegate = self
            keyFrameAnimation.duration = 1
            keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5 //add delay of 1 second
            keyFrameAnimation.values = [1.0, 0.8, 25.0] //scale percentages 1.0 = original size
            keyFrameAnimation.keyTimes = [0, 0.3, 1]
            keyFrameAnimation.isRemovedOnCompletion = false
            keyFrameAnimation.fillMode = kCAFillModeForwards;
            keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
            self.loadingMask!.add(keyFrameAnimation, forKey: "transform.scale")
        }
    }

}
