//
//  PortfolioItem.swift
//  DominicCheung
//
//  Created by Dominic's Macbook Pro on 26/04/2015.
//  Copyright (c) 2015 DominicCheung. All rights reserved.
//

import UIKit

class PortfolioItem: NSObject {
    
    var title: String
    var thumbnail: UIImage?
    
    init(title: String, thumbnail: UIImage?) {
        self.title = title
        self.thumbnail = thumbnail
        
        super.init()
    }
}
