//
//  RealNetworkResponseTest.swift
//  FlickrSearchTests
//
//  Created by Hana  Demas on 8/5/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import FlickrSearch

class RealNetworkResponseTest: XCTestCase {
    
    //MARK: Properties
    var flickrApiClient:FlickrAPIClient!
    
    override func setUp() {
        super.setUp()
        flickrApiClient = FlickrAPIClient(session: URLSession.shared)
    }
    
    //MARK: TestCases
    func testAPIResponse() {
        let testExpectation =  expectation(description: "flickr searched photos info expectation")
        
        flickrApiClient.fetchSearchedPhotos(for: "dog", completion: {(result) in
            
            switch result {
            case let .Success(photos):
                XCTAssert(photos.count <= 20, "more or less photos than expected \(photos.count)")
                testExpectation.fulfill()
            
            case let .Failure(error):
                print(error?.localizedDescription ?? "error")
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFlickrPhotoInitalizer() {
        let photo = FlickrPhoto(photoID: "1", farm: 1, server: "2" , secret: "1", title: "lovely dog")
        XCTAssertEqual(photo.photoID, "1", "The photo ID should be as expected")
        XCTAssertEqual(photo.farm, 1, "The farm should be as expected")
        XCTAssertEqual(photo.secret, "1", "The secret should be as expected")
        XCTAssertEqual(photo.title,  "lovely dog", "The photo title should be as expected")
        XCTAssertEqual(photo.server,  "2", "The photo server should be as expected")
    }
}
