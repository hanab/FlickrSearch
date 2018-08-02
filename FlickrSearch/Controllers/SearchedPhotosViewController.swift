//
//  ViewController.swift
//  FlickrSearch
//
//  Created by Hana  Demas on 7/31/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import UIKit

struct FlickrSearchResults {
    let searchString : String
    let searchResults : [FlickrPhoto]
}

class SearchedPhotosViewController: UIViewController {

    @IBOutlet var photosCollectionView: UICollectionView!
   
    @IBOutlet var searchBar: UITextField!
    var searchAPIDelegate: FlickrAPIClient?
    fileprivate var searches = [FlickrSearchResults]()
    
    fileprivate let reuseIdentifier = "cell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout Methods
extension SearchedPhotosViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
// MARK: - UITextFieldDelegate Methods
extension SearchedPhotosViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        let searchString = textField.text!
        if let ad = searchAPIDelegate {
            ad.fetchSearchedPhotos(for: searchString, completion: {(result) in
                
                switch result {
                case let .Success(photos):
                    DispatchQueue.main.async {
                        activityIndicator.removeFromSuperview()
                        let searchResultForTerm = FlickrSearchResults(searchString: searchString, searchResults: photos)
                        self.searches.insert(searchResultForTerm, at: 0)
                        self.photosCollectionView.reloadData()
                    }
                case let .Failure(error):
                    DispatchQueue.main.async {
                        activityIndicator.removeFromSuperview()
                        if let error = error {
                            // self.displayAlertWith(title: "Error", message: error.localizedDescription)
                        }
                    }
                }
            })}
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
    
    
}

extension SearchedPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FlickrPhotoCollectionViewCell
        let flickrPhoto = photoForIndexPath(indexPath: indexPath)
        cell.backgroundColor = UIColor.white
        cell.titleLabel.text = flickrPhoto.title
        cell.flickrImageView.loadImageUsingCacheWithURLString(flickrPhoto.flickrImageURLString()!, placeHolder: nil)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! FlickrHeaderCollectionReusableView
        if kind == UICollectionElementKindSectionHeader {
            header.headerLabel.text = searches[indexPath.section].searchString
        }
        return header
    }
    
    // MARK: - Private
    

}
private extension SearchedPhotosViewController {
    
    func photoForIndexPath(indexPath: IndexPath) -> FlickrPhoto {
        return searches[(indexPath as NSIndexPath).section].searchResults[(indexPath as IndexPath).row]
    }
}
