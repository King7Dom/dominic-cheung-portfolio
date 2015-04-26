//
//  AppContentManager.swift
//  DominicCheung
//
//  Created by Dominic's Macbook Pro on 26/04/2015.
//  Copyright (c) 2015 DominicCheung. All rights reserved.
//

import UIKit

let kPayloadSectionKey = "section"
let kPayloadSectionTitleKey = "section title"
let kPayloadSectionItemsKey = "section items"

let kPayloadItemTitleKey = "title"

class AppContentManager: NSObject {
    
    // MARK: Class
    
    class var sharedInstance: AppContentManager{
    
        struct Singleton {
            static let instance = AppContentManager()
        }
        return Singleton.instance
    }
    
    // MARK: Instance
    
    private var portfolio: [PortfolioSection]
    private var contentObservers: NSMutableArray
    
    override private init() {
        self.portfolio = [PortfolioSection]()
        self.contentObservers = NSMutableArray()
        
        super.init()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            self.loadLocalData()
        })
    }
    
    func addContentObserver(contentObserver: AnyObject) {
        if contentObserver is AppContentObserver {
            self.contentObservers.addObject(contentObserver)
        }
    }
    
    func removeContentObserver(contentObserver: AnyObject) {
        self.contentObservers.removeObject(contentObserver)
    }
    
    func loadLocalData() {
        
        var deserialisingError: NSError?
        let localFilePath = NSBundle.mainBundle().pathForResource("portfolio-content", ofType: "json")
        let jsonData = NSData(contentsOfFile: localFilePath!)
        let payload = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions(0), error: &deserialisingError) as? NSDictionary
        
        let sections: NSArray = payload![kPayloadSectionKey] as! NSArray
        for section in sections {
            let portfolioSection = PortfolioSection(sectionTitle: section[kPayloadSectionTitleKey] as! String, sectionItems: [])
            for sectionItem in section[kPayloadSectionItemsKey] as! NSArray {
                let portfolioItem = PortfolioItem(title: sectionItem[kPayloadItemTitleKey] as! String, thumbnail: nil)
                portfolioSection.sectionItems.append(portfolioItem)
            }
            self.portfolio.append(portfolioSection)
        }
        
        self.notifyContentObserversForContentUpdate()
    }
    
    func notifyContentObserversForContentUpdate() {
        for observer in contentObservers {
            let contentObserver = observer as! AppContentObserver
            contentObserver.portfolioContentUpdated(self.portfolio)
        }
    }
}

protocol AppContentObserver {
    func portfolioContentUpdated(portfolio: [PortfolioSection]) -> Void
}
