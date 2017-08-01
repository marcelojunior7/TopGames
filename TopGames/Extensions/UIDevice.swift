//
//  UIDevice.swift
//  TopGames
//
//  Created by Marcelo on 31/07/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import UIKit

extension UIDevice {
    var isSmallScreen: Bool {
        let screenMaxLength = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        return self.userInterfaceIdiom == .phone && screenMaxLength < 667.0
    }
}
