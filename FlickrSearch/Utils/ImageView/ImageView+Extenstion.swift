//
//  ImageView+Extenstion.swift
//  FlickrSearch
//
//  Created by Hana  Demas on 8/1/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    //UIImage extention to load and catch image asynchronously
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print("Image loading error: \(error )")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}


