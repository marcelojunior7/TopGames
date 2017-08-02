//
//  Game+CoreDataProperties.swift
//  TopGames
//
//  Created by Marcelo on 01/08/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var channels: Int64
    @NSManaged public var viewers: Int64
    @NSManaged public var thumbnail: String?

}
