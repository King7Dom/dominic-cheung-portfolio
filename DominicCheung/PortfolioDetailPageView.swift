//
//  PortfolioDetailPageView.swift
//  DominicCheung
//
//  Created by Dominic's Macbook Pro on 27/04/2015.
//  Copyright (c) 2015 DominicCheung. All rights reserved.
//

import UIKit

let kPageMargin: CGFloat = 8.0

class PortfolioDetailPageView: UIView {

    var scrollView: UIScrollView
    var imageView: UIImageView
    var bodyTextView: UITextView
    
    override init(frame: CGRect) {
        self.scrollView = UIScrollView()
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        
        self.bodyTextView = UITextView(frame: CGRectMake(0, 0, 100, 100))
        self.bodyTextView.editable = false
        self.bodyTextView.dataDetectorTypes = UIDataDetectorTypes.Link
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        self.imageView.backgroundColor = UIColor.darkGrayColor()
        
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.imageView)
        self.scrollView.addSubview(self.bodyTextView)
    }

    required convenience init(coder aDecoder: NSCoder) {
        self.init(frame: CGRectZero)
    }
    
    override func layoutSubviews() {
        self.scrollView.frame = self.bounds
        
        let bodyWidth = CGRectGetWidth(self.bounds) - CGFloat(2 * kPageMargin)
        self.imageView.frame = CGRectMake(kPageMargin, kPageMargin, bodyWidth, bodyWidth * 9 / 16)
        
        let imageFrame = self.imageView.frame
        self.bodyTextView.contentSize.width = bodyWidth
        self.bodyTextView.frame = CGRectMake(kPageMargin, imageFrame.origin.y + CGRectGetHeight(imageFrame) + kPageMargin, bodyWidth, self.bodyTextView.contentSize.height)
        
        self.scrollView.contentSize = CGSize(width: CGRectGetWidth(self.bounds), height: CGRectGetHeight(imageFrame) + CGRectGetHeight(self.bodyTextView.frame) + (2 * kPageMargin))
        self.scrollView.directionalLockEnabled = true
    }
}
