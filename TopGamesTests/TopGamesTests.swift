//
//  TopGamesTests.swift
//  TopGamesTests
//
//  Created by Marcelo on 31/07/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import XCTest
@testable import TopGames

class TopGamesTests: XCTestCase {
    
    var mainViewController: MainViewController!
    
    override func setUp() {
        super.setUp()
        mainViewController = MainViewController.instance()
        mainViewController.preload()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    func testNumberOfItemsInTheCollectionMustBeEqualToTheNumberOfItemsInTheArray() {
        mainViewController.games = ["item 1", "item 2"]
        XCTAssertEqual(mainViewController.collectionView?.numberOfItems(inSection: 0), 2, "numbers of items in collectionView should be equal to 2")
    }
}
