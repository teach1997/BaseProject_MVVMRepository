//
//  UIColor+.swift
//  BaseProjectRxSwift
//
//  Created by Kiều anh Đào on 5/29/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    var image: UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(self.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    convenience init(rgbValue: UInt) {
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                   green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                   blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                   alpha: 1.0)
    }
    
    convenience init(rgbValue: UInt, alpha: CGFloat) {
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    func convertToRGB() -> UInt {
        let components = self.cgColor.components!
        let red: UInt = UInt(components[0] * 255) << 16
        let green: UInt = UInt(components[1] * 255) << 8
        let blue: UInt = UInt(components[2] * 255)
        return red | green | blue
    }
}

