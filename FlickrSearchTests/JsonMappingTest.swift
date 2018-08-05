//
//  JsonMappingTest.swift
//  FlickrSearchTests
//
//  Created by Hana  Demas on 8/4/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import FlickrSearch

class JsonMappingTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    //MARK: TestCases
    func testJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "testPhotosSample", withExtension: "json") else {
            XCTFail("Missing file: testPhotosSample.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        let photoResult:PhotosResult = FlickrAPI.flickrPhotosFromJSONData(data:json)
        XCTAssertNotNil(photoResult)
        let photos = photoResult.getPhotos()
        XCTAssertEqual(photos?.count, 20)
        
        //sample test of the second entry
        guard let photosFromJson = photos else {
            return
        }
        XCTAssertEqual(photosFromJson[1].title, "DSC_0137")
        XCTAssertEqual(photosFromJson[1].farm, 2)
        XCTAssertEqual(photosFromJson[1].server, "1837")
        XCTAssertEqual(photosFromJson[1].secret, "2c01c088a1")
        XCTAssertEqual(photosFromJson[1].photoID, "42033441540")
    }
}
