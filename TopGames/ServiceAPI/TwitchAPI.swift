//
//  TwitchAPI.swift
//  TopGames
//
//  Created by Marcelo on 31/07/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON

struct TwitchAPIKeys {
    static let baseURL = "https://api.twitch.tv/kraken/games/"
    static let top50 = baseURL + "/top?limit=50"
    static let headers: HTTPHeaders = [
        "Accept": "application/json",
        "Client-ID": "cdvunutz7u00mxz9ndhz42btrdgld0"
    ]
}

class TwitchAPI : NSObject {
    
    func top(success:@escaping ((_ games:[Game]) -> Void), fail:@escaping ((_ error:Error?) -> Void)) {
        
        Alamofire.request(TwitchAPIKeys.top50, parameters:nil, headers:TwitchAPIKeys.headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                var games = [Game]()
                if let result = response.result.value {
                    let json = JSON(result)
                    games = json["top"].arrayValue.map({Game(json: $0)})
                }
                success(games)
            case .failure(let error):
                print(error)
                fail(error)
            }
        }
    }
    
    
    
}

