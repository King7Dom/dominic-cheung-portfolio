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
    
    private var portfolio: [PortfolioSection]
    private let cellReuseIdentifier = "PortfolioItemCell"
    private let headerReuseIdentifier = "PortfolioHeaderView"
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: kCellVerticalMargin, right: 0)
    var columns: Int
    
    required init(coder aDecoder: NSCoder) {
        self.portfolio = []
        
        let section1 = PortfolioSection(sectionTitle: "Hello World", sectionItems: [])
        section1.sectionItems.append(PortfolioItem(title: "Hello World", thumbnail: nil))
        section1.sectionItems.append(PortfolioItem(title: "Hello World Again", thumbnail: nil))
        section1.sectionItems.append(PortfolioItem(title: "Hello World Again and Again", thumbnail: nil))
        
        let section2 = PortfolioSection(sectionTitle: "Cool Section", sectionItems: [])
        section2.sectionItems.append(PortfolioItem(title: "11", thumbnail: nil))
        section2.sectionItems.append(PortfolioItem(title: "22", thumbnail: nil))
        section2.sectionItems.append(PortfolioItem(title: "33", thumbnail: nil))

        let section3 = PortfolioSection(sectionTitle: "Last Section", sectionItems: [])
        section3.sectionItems.append(PortfolioItem(title: "111", thumbnail: nil))
        section3.sectionItems.append(PortfolioItem(title: "222", thumbnail: nil))
        section3.sectionItems.append(PortfolioItem(title: "333", thumbnail: nil))
        section3.sectionItems.append(PortfolioItem(title: "444", thumbnail: nil))
        section3.sectionItems.append(PortfolioItem(title: "555", thumbnail: nil))
        section3.sectionItems.append(PortfolioItem(title: "666", thumbnail: nil))
        section3.sectionItems.append(PortfolioItem(title: "777", thumbnail: nil))
        section3.sectionItems.append(PortfolioItem(title: "888", thumbnail: nil))
        section3.sectionItems.append(PortfolioItem(title: "999", thumbnail: nil))
        
        self.portfolio += [section1, section2, section3]
        
        self.columns = 0
        
        super.init(coder: aDecoder)
        
        self.calculateNumberOfColumns()
    }
    
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
    }
    
    // MARK: Methods
    
    func calculateNumberOfColumns() {
        self.columns = 3
    }
}

// MARK: UICollectionViewDataSource

extension PortfolioCollectionViewController: UICollectionViewDataSource {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.portfolio.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.portfolio[section].sectionItems.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! PortfolioCollectionViewCell
        cell.backgroundColor = UIColor.darkGrayColor()
        cell.title.text = self.portfolio[indexPath.section].sectionItems[indexPath.row].title
        
        if (self.portfolio[indexPath.section].sectionItems[indexPath.row].thumbnail != nil) {
            cell.imageView.image = self.portfolio[indexPath.section].sectionItems[indexPath.row].thumbnail
        } else {
            cell.imageView.backgroundColor = UIColor.lightGrayColor()
        }
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerReuseIdentifier, forIndexPath: indexPath) as! PortfolioSectionHeaderView
            headerView.label.text = self.portfolio[indexPath.section].sectionTitle
            return headerView
        default:
            assert(false, "Unexpected UICollectionElementOfKind: \(kind)")
        }
    }
}

// MARK: UICollectionViewDelegate

extension PortfolioCollectionViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension PortfolioCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellWidth = (CGRectGetWidth(collectionView.bounds) - (kCellHorizontalMargin * CGFloat(columns-1))) / CGFloat(columns)
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kCellHorizontalMargin
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kCellVerticalMargin
    }
}