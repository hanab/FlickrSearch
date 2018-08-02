//
//  PhotoDetailViewController.swift
//  FlickrSearch
//
//  Created by Hana  Demas on 8/2/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet var photoImageView: UIImageView!
    var selectedPhoto: FlickrPhoto?
    
    @IBOutlet var photoTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView(with: selectedPhoto)
    }
    
    func setupView(with photo: FlickrPhoto?) {
        guard let photo = photo else {
            return
        }
        
        photoImageView.loadImageUsingCacheWithURLString(photo.flickrImageURLString()!, placeHolder: nil)
        photoTitleLabel.text = photo.title
    }
}
