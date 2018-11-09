//
//  ModelTests.swift
//  PhotoAppTests
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

@testable import PhotoApp
import XCTest

class ParseTests: XCTestCase {
    func testIfPhotoModelIsParsed() {
        guard let data = loadData(file: "photo") else {
            XCTFail("No data found")
            return
        }

        do {
            let photo = try JSONDecoder().decode(Photo.self, from: data)
            XCTAssertEqual(photo.id, 2)
            XCTAssertEqual(photo.title, "reprehenderit est deserunt velit ipsam")
            XCTAssertEqual(photo.url, "https://via.placeholder.com/600/771796")
            XCTAssertEqual(photo.thumbnailUrl, "https://via.placeholder.com/150/771796")
        } catch let error {
            XCTFail("Parsing failure: \(error)")
        }

    }

    func testIfPhotoListModelIsParsed() {
        guard let data = loadData(file: "photos") else {
            XCTFail("No data found")
            return
        }

        do {
            let photoList = try JSONDecoder().decode([Photo].self, from: data)
            XCTAssertEqual(photoList.count, 2)
        } catch let error {
            XCTFail("Parsing failure: \(error)")
        }

    }

}
