//
//  Game+CoreDataClass.swift
//  TopGames
//
//  Created by Marcelo on 01/08/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

public class Game: NSManagedObject {

    class func createGame(json : JSON) {
        let context = DataManager.shared.context
        if let gameEntity = NSEntityDescription.insertNewObject(forEntityName: "Game", into: context) as? Game {
            gameEntity.id = json["game"]["_id"].string ?? ""
            gameEntity.name = json["game"]["name"].string ?? ""
            gameEntity.channels = json["channels"].int64 ?? 0
            gameEntity.viewers = json["viewers"].int64 ?? 0
            gameEntity.thumbnail = json["game"]["box"]["large"].string ?? ""
        }
    }
    
    class func mock() -> Game{
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Game", in: DataManager.shared.context)!
        let game = Game(entity: entity, insertInto: DataManager.shared.context)
        return game
    }
    
    func validate() -> NSDictionary {
        let errors:NSMutableDictionary = [:]
        if (name == nil || name == "") {
            errors["name"] = "Name is require"
        }
        return errors
    }
}
