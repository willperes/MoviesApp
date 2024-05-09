//
//  UIColor.swift
//  MoviesApp
//
//  Created by Willian Peres on 09/05/24.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        func randomFloat() -> CGFloat {
            return CGFloat(arc4random()) / CGFloat(UInt32.max)
        }
        
        return UIColor(
           red: randomFloat(),
           green: randomFloat(),
           blue: randomFloat(),
           alpha: 1.0
        )
    }
}
