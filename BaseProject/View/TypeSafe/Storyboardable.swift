//
//  Storyboardable.swift
//  DHBC
//
//  Created by Kiều anh Đào on 9/14/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboardable: NSObjectProtocol {
    static var storyboardName: String { get }
    static func instantiate() -> Self
}

extension Storyboardable where Self: UIViewController {
    static var storyboardName: String {
        return className.replacingOccurrences(of: "ViewController", with: "Storyboard")
    }

    static var segueIdentifier: String {
        return className.replacingOccurrences(of: "ViewController", with: "")
    }
    
    static func instantiate() -> Self {
        return UIStoryboard(name: storyboardName, bundle: Bundle(for: self)).instantiateInitialViewController() as! Self
    }
    
    static func instantiate(storyboardName: String) -> Self {
        return UIStoryboard(name: storyboardName, bundle: Bundle(for: self)).instantiateInitialViewController() as! Self
    }
}

