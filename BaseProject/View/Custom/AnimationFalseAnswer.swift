//
//  AnimationFalseAnswer.swift
//  DHBC
//
//  Created by Kiều anh Đào on 7/6/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import Foundation
import UIKit

class AnimationFalseAnswer {
    static let shared = AnimationFalseAnswer()
    
    func shakeView(_ view: UICollectionView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.04
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 3, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 3, y: view.center.y))

        view.layer.add(animation, forKey: "position")
    }
}
