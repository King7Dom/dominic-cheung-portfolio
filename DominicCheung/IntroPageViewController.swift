//
//  IntroPageViewController.swift
//  DominicCheung
//
//  Created by Dominic's Macbook Pro on 23/04/2015.
//  Copyright (c) 2015 DominicCheung. All rights reserved.
//

import UIKit

let kButtonCornerRadius : CGFloat = 4.0


class IntroPageViewController: UIPageViewController {
    
    let closeButton : UIButton
    let pageControl : UIPageControl
    var dismissDelegate : IntroPageDismissDelegate? = nil
    var pages : [[String : String]]
    
    // MARK: Initialiser
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [NSObject : AnyObject]?) {
        // Setup placeholder content for PageContentViewController
        let page1 : [String : String] = [
            "Title": "Hello World",
            "Description": "Hello Hello Hello"
        ]
        let page2 : [String : String] = [
            "Title": "Hello World Again",
            "Description": "Hello Hello Hello Hello"
        ]
        let page3 : [String : String] = [
            "Title": "Hello World Again and Again",
            "Description": "Hello Hello Hello Hello Hello"
        ]
        self.pages = [page1, page2, page3]

        // Setup Close Button
        self.closeButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        self.closeButton.setTitle("Close", forState: UIControlState.Normal)
        self.closeButton.sizeToFit()
        self.closeButton.layer.cornerRadius = kButtonCornerRadius
        self.closeButton.backgroundColor = UIColor.whiteColor()
        self.closeButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.closeButton.alpha = 0.8
        
        // Setup Page Control
        self.pageControl = UIPageControl()
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.sizeToFit()
        self.pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
        
        // Setup UIControl Target and Action
        self.closeButton.addTarget(self, action: Selector("closePage:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.pageControl.addTarget(self, action: Selector("changePage:"), forControlEvents: UIControlEvents.ValueChanged)
        
        // Set self as datasource and delegate
        weak var weakSelf = self
        self.delegate = weakSelf
        self.dataSource = weakSelf
    }

    convenience required init(coder aDecoder: NSCoder) {
        self.init(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add button to view
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.pageControl)
        
        // Setup layout constraints
        self.closeButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.pageControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        let viewDictionary : [NSObject : AnyObject] = [
            "closeButton": self.closeButton,
            "pageControl": self.pageControl,
            "topLayoutGuide": topLayoutGuide
        ]
        let constraints : NSMutableArray = []
        constraints.addObjectsFromArray(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[closeButton]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: viewDictionary))
        constraints.addObjectsFromArray(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[closeButton]", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: viewDictionary))
        constraints.addObjectsFromArray(NSLayoutConstraint.constraintsWithVisualFormat("V:[pageControl]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: viewDictionary))
        constraints.addObjectsFromArray(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[pageControl]-|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: viewDictionary))
        self.view.addConstraints(constraints as [AnyObject])
        
        self.view.layoutSubviews()
        
        // Setup startup PageContentViewController
        let startingViewController : UIViewController = viewControllerAtIndex(0)!
        self.setViewControllers([startingViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set frame for slide in animation
        self.view.frame.origin.x = self.view.frame.size.width
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.frame.origin.x = 0.0
        })
    }
    
    // MARK: UIButton Target and Action Methods
    
    func changePage(sender:UIPageControl!) {
        println("Changed page to " + String(self.pageControl.currentPage))
        // Setup startup PageContentViewController
        let currentViewController : IntroPageContentViewController = viewControllers[0] as! IntroPageContentViewController
        let nextViewController : IntroPageContentViewController = viewControllerAtIndex(self.pageControl.currentPage)!
        let direction = nextViewController.pageIndex > currentViewController.pageIndex ? UIPageViewControllerNavigationDirection.Forward : UIPageViewControllerNavigationDirection.Reverse
        self.setViewControllers([nextViewController], direction: direction, animated: true, completion: nil)

    }
    
    func closePage(sender:UIButton!) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.alpha = 0.0
        }) { (Bool) -> Void in
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
            self.dismissDelegate?.dismissIntroPage()
        }
    }
}

// MARK: UIPageViewControllerDataSource

extension IntroPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! IntroPageContentViewController).pageIndex
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        index--
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! IntroPageContentViewController).pageIndex
        if (index >= self.pages.count - 1 || index == NSNotFound) {
            return nil
        }
        index++
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> IntroPageContentViewController? {
        if (self.pages.count == 0 || index >= self.pages.count) {
            return nil
        }
        
        let pageContentViewController = IntroPageContentViewController(nibName: "IntroPageContentViewController", bundle: nil)
        pageContentViewController.view.frame = self.view.bounds
        pageContentViewController.mainText = self.pages[index]["Title"]!
        pageContentViewController.descriptionText = self.pages[index]["Description"]!
        pageContentViewController.pageIndex = index
        
        return pageContentViewController
    }
}

// MARK: UIPageViewControllerDelegate

extension IntroPageViewController : UIPageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        if (completed && finished) {
            let currentViewController : IntroPageContentViewController = self.viewControllers[0] as! IntroPageContentViewController
            self.pageControl.currentPage = currentViewController.pageIndex != self.pageControl.currentPage ? currentViewController.pageIndex : self.pageControl.currentPage
            self.pageControl.updateCurrentPageDisplay()
        }
    }
}

// MARK: IntroPageDismissDelegate

protocol IntroPageDismissDelegate {
    func dismissIntroPage() -> Void
}
