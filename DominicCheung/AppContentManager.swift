//
//  AppContentManager.swift
//  DominicCheung
//
//  Created by Dominic's Macbook Pro on 26/04/2015.
//  Copyright (c) 2015 DominicCheung. All rights reserved.
//

import UIKit

class AppContentManager: NSObject {
    
    class var sharedInstance: AppContentManager{
    
        struct Singleton {
            static let instance = AppContentManager()
        }
        return Singleton.instance
    }
    
    var portfolio: [PortfolioSection]
    
    override private init() {
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
        
        super.init()
    }
}
