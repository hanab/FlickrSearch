//
//  FlickrDataStore.swift
//  FlickrSearch
//
//  Created by Hana  Demas on 8/1/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation

class FlickrAPIClient {
    
    private func fetchFlickerPhotos(url: URL, completion: @escaping (_ photos: PhotosResult) -> ()) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler:  { (data, response, error) -> Void in
            let results = self.processFlickrRequest(data: data, error: error)
            completion(results)
        })
        task.resume()
    }
    
    //Get all photos from json data
    func processFlickrRequest(data: Data?, error: Error?) -> PhotosResult {
        guard data != nil else {
            return .Failure(error)
        }
        return FlickrAPI.flickrPhotosFromJSONData(data: data)
    }
    
    //Get all photos from search end point
    func fetchSearchedPhotos(for term:String, completion: @escaping (_ photos: PhotosResult) -> ()) {
        let url = FlickrAPI.searchedResultsURL(for: term)
        fetchFlickerPhotos(url: url, completion: completion)
    }
}
