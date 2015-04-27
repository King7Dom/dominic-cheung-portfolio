//
//  PortfolioDetailViewController.swift
//  DominicCheung
//
//  Created by Dominic's Macbook Pro on 27/04/2015.
//  Copyright (c) 2015 DominicCheung. All rights reserved.
//

import UIKit

class PortfolioDetailViewController: UIViewController {

    var indexPath: NSIndexPath?
    var content: PortfolioItem?
    
    override func loadView() {
        self.view = PortfolioDetailPageView(frame: CGRectZero)
        self.view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.content = AppContentManager.sharedInstance.portfolioItemAtIndexPath(self.indexPath!)
        self.title = content!.title
        let view = self.view as! PortfolioDetailPageView
        view.bodyTextView.text = content!.bodyText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}