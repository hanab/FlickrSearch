//
//  FlickrAPI.swift
//  FlickrSearch
//
//  Created by Hana  Demas on 8/1/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation

enum Method: String {
    case Search = "flickr.photos.search"
}
enum PhotosResult {
    case Success([FlickrPhoto])
    case Failure(Error?)
}

enum FlickrError: Error{
    case InvalidJSONData
    case NoData
}
// structure for generating the full url
struct FlickrAPI {
    
    //MARK: Properies
    fileprivate static let baseURLString = "https://api.flickr.com/services/rest"
    fileprivate static let APIKey="cc515094ccc0e681f4f310ea2dc07d7b"
    
    
    //MARK: Methods
    fileprivate static func flickrURL(method: Method, searchString: String, parameters: [String:String]?) -> URL {
        
         let escapedTerm = searchString.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) ?? ""
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback":"1",
            "per_page": "20",
            "api_key": APIKey,
            "text": escapedTerm
            
        ]
        
        for (key,value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key,value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        return components.url!
    }
    
    //static function to get the searched
    static func searchedResultsURL(for string: String) -> URL {
        return flickrURL(method: Method.Search, searchString: string,  parameters: nil)
    }
    
    //Function to construct FlickrPhoto object from json
    private static func flickrPhotoFromJSONObject(json: [String : AnyObject]) -> FlickrPhoto? {
        guard let photoID = json["id"] as? String,
            let farm = json["farm"] as? Int ,
            let server = json["server"] as? String ,
            let secret = json["secret"] as? String,
            let title = json["title"] as? String else {
            return nil
        }
        return FlickrPhoto(photoID: photoID, farm: farm, server: server, secret: secret,title: title)
    }
    
    //Get all tickets from json
    static func flickrPhotosFromJSONData(data: Data?) -> PhotosResult {
        do {
            guard let data = data  else {
                return .Failure(FlickrError.NoData)
            }
            let jsonObject: AnyObject = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
            guard let jsonObjectDictionary = jsonObject["photos"] as? [String: AnyObject], let photosArray = jsonObjectDictionary ["photo"] as? [[String: AnyObject]] else {
                return .Failure( FlickrError.InvalidJSONData)
            }
            
            var finalPhotos = [FlickrPhoto]()
            
            for photosJSON in photosArray {
                if let photo = flickrPhotoFromJSONObject(json: photosJSON) {
                    finalPhotos.append(photo)
                }
            }
            
            if finalPhotos.isEmpty && !photosArray.isEmpty {
                return .Failure(FlickrError.InvalidJSONData)
            }
            return .Success(finalPhotos)
        }
        catch let error {
            return .Failure(error)
        }
    }
}


