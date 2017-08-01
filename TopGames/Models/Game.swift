//
//  Game.swift
//  TopGames
//
//  Created by Marcelo on 31/07/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Game : NSObject {
    
    var id: Int = 0
    var name: String = ""
    var channels = 0
    var viewers = 0
    var thumbnail = ""
    
    override init() {
        super.init()
    }
    
    init(json : JSON) {
        super.init()
        id = json["game"]["_id"].int ?? id
        name = json["game"]["name"].string ?? name
        channels = json["channels"].int ?? channels
        viewers = json["viewers"].int ?? viewers
        thumbnail = json["game"]["box"]["large"].string ?? thumbnail
    }
}
