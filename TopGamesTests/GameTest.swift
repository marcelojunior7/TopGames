//
//  GameTest.swift
//  TopGames
//
//  Created by Marcelo on 02/08/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import XCTest
import CoreData
@testable import TopGames

class GameTest: XCTestCase {
    
    var context: NSManagedObjectContext?
    
    override func setUp() {
        super.setUp()
        context = DataManager.shared.context
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNameShouldBeRequired() {
        let game = Game.mock()
        let errors: NSDictionary = game.validate()
        
        XCTAssertEqual(1, errors.count, "Must contain 1 error when name is empty")
        XCTAssertTrue((errors.value(forKey: "name") != nil), "Must contain :name error when name is empty")
    }
    
}
