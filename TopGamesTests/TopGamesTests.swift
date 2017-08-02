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
            
        }
    }
    
    func testCellIsReady() {
        mainViewController.filteredGames = [Game.mock()]
        mainViewController.collectionView.reloadData()
        let firstCell = mainViewController.collectionView(mainViewController.collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as? MainCollectionViewCell
        XCTAssertNotNil(firstCell, "cell is invalid")
    }
    
    func testNumberOfItemsInTheCollectionMustBeEqualToTheNumberOfItemsInTheArray() {
        mainViewController.filteredGames = [Game.mock(), Game.mock()]
        XCTAssertEqual(mainViewController.collectionView?.numberOfItems(inSection: 0), 2, "numbers of items in collectionView should be equal to 2")
    }
    
    func testDataAreRightsOnCollectionView() {
        let game = Game.mock()
        game.name = "yolo"
        game.thumbnail = "http://images.math.cnrs.fr/IMG/png/section8-image.png"
        
        mainViewController.filteredGames = [game, game]
        mainViewController.collectionView.reloadData()
        let firstCell = mainViewController.collectionView(mainViewController.collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as! MainCollectionViewCell
        
        XCTAssertEqual(firstCell.labelTitle.text, "yolo", "names is not equal of the model")
        XCTAssertNotNil(firstCell.imageMain.image, "thumbnail is invalid")
    }
}
