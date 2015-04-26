//
//  RootViewController.swift
//  DominicCheung
//
//  Created by Dominic's Macbook Pro on 23/04/2015.
//  Copyright (c) 2015 DominicCheung. All rights reserved.
//

import UIKit

let kHaveShownIntroKey : String = "have_shown_intro"

class RootViewController : UIViewController {
    
    var introPageViewController : IntroPageViewController?
    var portfolioCollectionViewController : UINavigationController
    
    // MARK: Initialiser
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        // Setup PortfolioCollectionViewController
        let portfolioCollectionStoryboard : UIStoryboard = UIStoryboard(name: "PortfolioCollectionStoryboard", bundle: nil)
        portfolioCollectionViewController = portfolioCollectionStoryboard.instantiateInitialViewController() as! UINavigationController
        
        super.init(nibName: nil, bundle: nil)
    }

    required convenience init(coder aDecoder: NSCoder) {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController(self.portfolioCollectionViewController)
        self.view.addSubview(self.portfolioCollectionViewController.view)
        self.portfolioCollectionViewController.didMoveToParentViewController(self)
        
        
        if (NSUserDefaults.standardUserDefaults().boolForKey(kHaveShownIntroKey) == false) {
            self.displayIntro()
        }
    }
    
    // MARK: Methods
    
    // Display IntroPage
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

// MARK: IntroPageDismissDelegate

extension RootViewController : IntroPageDismissDelegate {
    
    func dismissIntroPage() {
        self.introPageViewController = nil
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: kHaveShownIntroKey)
    }
}
