//
//  FlickerPhoto.swift
//  FlickrSearch
//
//  Created by Hana  Demas on 8/1/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation
import UIKit

struct FlickrPhoto {
    
    let photoID : String
    let farm : Int
    let server : String
    let secret : String
    let title : String
    
    func flickrImageURLString(_ size:String = "m") -> String? {
        return  "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg"
    }
}
