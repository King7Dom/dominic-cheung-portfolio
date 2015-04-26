//
//  PortfolioCollectionViewController.swift
//  DominicCheung
//
//  Created by Dominic's Macbook Pro on 26/04/2015.
//  Copyright (c) 2015 DominicCheung. All rights reserved.
//

import UIKit

let kCellVerticalMargin: CGFloat = 2.5
let kCellHorizontalMargin: CGFloat = 2.5

class PortfolioCollectionViewController: UICollectionViewController {
    
    private var portfolio: [[String]] = [
        ["Hello World", "Hello World Again", "Hello World Again and Again"],
        ["11", "22", "33"],
        ["111", "222", "333", "444", "555", "666", "777", "888", "999", "000"]
    ]
    var columns: Int = 0
    private let reuseIdentifier = "PortfolioItemCell"
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: kCellVerticalMargin, right: 0)
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.calculateNumberOfColumns()
    }
    
    // MARK: Methods
    
    func calculateNumberOfColumns() {
        self.columns = 3
        self.collectionView?.reloadData()
    }
}

// MARK: UICollectionViewDataSource

extension PortfolioCollectionViewController: UICollectionViewDataSource {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.portfolio.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.portfolio[section].count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PortfolioCollectionViewCell
        cell.backgroundColor = UIColor.darkGrayColor()
        cell.title.text = self.portfolio[indexPath.section][indexPath.row]
        cell.imageView.backgroundColor = UIColor.lightGrayColor()
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension PortfolioCollectionViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension PortfolioCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellWidth = (CGRectGetWidth(collectionView.bounds) - (kCellHorizontalMargin * CGFloat(columns))) / CGFloat(columns)
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kCellHorizontalMargin
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kCellVerticalMargin
    }
}