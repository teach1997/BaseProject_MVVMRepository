//
//  UIImage+.swift
//  DHBC
//
//  Created by Kiều anh Đào on 9/14/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(forResource resource: String, ofType type: String = "png") {
        let resolution = "@" + String(Int(UIScreen.main.scale)) + "x"
        guard let imagePath = Bundle.main.path(forResource: resource + resolution, ofType: type) else {
            return nil
        }
        self.init(contentsOfFile: imagePath)
    }
}
