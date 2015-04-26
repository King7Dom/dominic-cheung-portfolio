//
//  IntroPageContentViewController.swift
//  DominicCheung
//
//  Created by Dominic's Macbook Pro on 23/04/2015.
//  Copyright (c) 2015 DominicCheung. All rights reserved.
//

import UIKit

class IntroPageContentViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var mainText: String
    var descriptionText: String
    var pageIndex: Int
    
    // MARK: Initialiser
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.mainText = ""
        self.descriptionText = ""
        self.pageIndex = 0
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    convenience required init(coder aDecoder: NSCoder) {
        self.init(nibName: "IntroPageContentViewController", bundle: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.backgroundColor = UIColor.redColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mainLabel.text = self.mainText
        self.descriptionLabel.text = self.descriptionText
    }
}