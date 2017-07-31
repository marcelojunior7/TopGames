//
//  DetailsViewController.swift
//  TopGames
//
//  Created by Marcelo on 31/07/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    class func instance() -> DetailsViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Details") as! DetailsViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
