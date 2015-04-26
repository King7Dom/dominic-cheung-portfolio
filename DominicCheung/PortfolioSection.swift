//
//  PortfolioSection.swift
//  DominicCheung
//
//  Created by Dominic's Macbook Pro on 26/04/2015.
//  Copyright (c) 2015 DominicCheung. All rights reserved.
//

import UIKit

class PortfolioSection: NSObject {
   
    var sectionTitle: String
    var sectionItems: [PortfolioItem]
    
    // MARK: Initialiser
    
    init(sectionTitle: String, sectionItems: [PortfolioItem]) {
        self.sectionTitle = sectionTitle
        self.sectionItems = sectionItems
        
        super.init()
    }
}
