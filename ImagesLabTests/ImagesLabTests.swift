//
//  ImagesLabTests.swift
//  ImagesLabTests
//
//  Created by Angela Garrovillas on 9/5/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import XCTest
@testable import ImagesLab

class ImagesLabTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testXkcdComic() {
        let urlString = "https://xkcd.com/1/info.0.json"
        let comic = XkcdComic()
        NetworkManager.shared.fetchData()
        XCTAssertTrue(comic != nil, "expected comic got nil")
    }

}
