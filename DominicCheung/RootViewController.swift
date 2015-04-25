//
//  RootViewController.swift
//  DominicCheung
//
//  Created by Dominic's Macbook Pro on 23/04/2015.
//  Copyright (c) 2015 DominicCheung. All rights reserved.
//

import UIKit

let kFirstTimeUserKey = "firstTimeUser"

class RootViewController : UIViewController {
    
    var introPageViewController : IntroPageViewController?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
        
        if (NSUserDefaults.standardUserDefaults().boolForKey(kFirstTimeUserKey) != false) {
            
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayIntro()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayIntro() {
        self.introPageViewController = IntroPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        self.introPageViewController!.dismissDelegate = self
        
        if let introPageVC = self.introPageViewController {
            self.addChildViewController(introPageVC)
            if ((self.view) != nil) {
                introPageVC.view.frame = self.view.bounds
                let subviews : NSArray = self.view.subviews
                if (!subviews.containsObject(introPageVC)) {
                    self.view.addSubview(introPageVC.view!)
                    introPageVC.didMoveToParentViewController(self)
                }
            }
        }
    }
}

extension RootViewController : IntroPageDismissDelegate {
    
    func dismissIntroPage() {
        self.introPageViewController = nil
    }
}
