//
//  Font+Extension.swift
//  FlickrSearch
//
//  Created by Hana  Demas on 8/5/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation

import Foundation
import UIKit

extension UIFont {
    
    class func fontRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    class func fontBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
}

struct Font {
    static let regular12 = UIFont.fontRegular(12)
    static let bold17 = UIFont.fontBold(17)
}
