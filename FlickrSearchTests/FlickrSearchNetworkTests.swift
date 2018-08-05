//
//  FlickrSearchTests.swift
//  FlickrSearchTests
//
//  Created by Hana  Demas on 7/31/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import FlickrSearch

class FlickrSearchNetworkTests: XCTestCase {
    
    //MARK: Properties
    var flickrApiClient:FlickrAPIClient!
    var session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        flickrApiClient = FlickrAPIClient(session: session)
    }
    
    //MARK: TestCases
    func testDataTaskResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.mockDataTask = dataTask
        
        flickrApiClient.fetchSearchedPhotos(for: "dog",  completion: {(result) in
            //nothing to do with the results for this test
        })
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testDataTaskReturnPhotos() {
        let dataTask = MockURLSessionDataTask()
        session.mockDataTask = dataTask
        
        guard let url = URL(string: "https://myurl") else {
            fatalError("URL can't be empty")
        }
        
        flickrApiClient.fetchFlickerPhotos(url: url, completion: {_ in
            //nothing to do with the results for this test
        })
        
        XCTAssert((session.mockURL == url))
    }
    
    func testSuccessfulResponse() {
        let data = "{}".data(using: .utf8)
        session.mockData = data
        
        let url = URL(fileURLWithPath: "url")
        var actualData: PhotosResult?
        
        flickrApiClient.fetchFlickerPhotos(url: url, completion: {(result) in
            actualData = result
        })
        
        XCTAssertNotNil(actualData)
    }
}
