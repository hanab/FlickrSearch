//
//  PhotoDetailViewController.swift
//  FlickrSearch
//
//  Created by Hana  Demas on 8/2/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    //MARK: UIOutlets and Properties
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var photoTitleLabel: UILabel!
    
    var selectedPhoto: FlickrPhoto?
    
    //MARK: ViewController lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(share(sender:)))
        
        setupView(with: selectedPhoto)
    }
    
    //MARK: Custom funtions
    func setupView(with photo: FlickrPhoto?) {
        guard let photo = photo else {
            return
        }
        self.title = photo.title
        photoImageView.loadImageUsingCacheWithURLString(photo.flickrImageURLString() ?? "", placeHolder:  UIImage(named: "placeholder"))
        photoTitleLabel.text = photo.title
    }
    
    //MARK: IBActions
    @IBAction func openImageInBrowser(_ sender: Any) {
        guard let photo = selectedPhoto, let urlString = photo.flickrImageURLString() else {
            return
        }
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
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
