//
//  headerCollectionReusableView.swift
//  FlickrSearch
//
//  Created by Hana  Demas on 8/1/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import UIKit

class FlickrHeaderCollectionReusableView: UICollectionReusableView {
    
    //MARK: UIOutlets
    @IBOutlet var headerLabel: UILabel!
    
    //MARK: Functions
    func styleElements() {
        headerLabel.font = Font.bold17
        self.backgroundColor = UIColor.flickrYellow()
    }
}
