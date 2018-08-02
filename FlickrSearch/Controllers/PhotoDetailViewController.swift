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
    @IBOutlet var photoTitleLabel: UILabel!
    
    var selectedPhoto: FlickrPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(sender:)))
        
        setupView(with: selectedPhoto)
    }
    
    func setupView(with photo: FlickrPhoto?) {
        guard let photo = photo else {
            return
        }
        
        photoImageView.loadImageUsingCacheWithURLString(photo.flickrImageURLString()!, placeHolder: nil)
        photoTitleLabel.text = photo.title
    }
    
    @objc func share(sender:UIButton){
        let image = self.photoImageView.image
        let imageToShare = [ image! ]
        
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}
