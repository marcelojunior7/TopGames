//
//  UILabel.swift
//  TopGames
//
//  Created by Marcelo on 02/08/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import UIKit

extension UILabel {
    func stroke(text:String) {
        let strokeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSStrokeWidthAttributeName : -1.0,
            ] as [String : Any]
        self.attributedText = NSAttributedString(string: text, attributes: strokeTextAttributes)
    }
}
