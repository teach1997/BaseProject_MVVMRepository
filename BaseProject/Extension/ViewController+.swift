//
//  ViewController+.swift
//  BaseProjectRxSwift
//
//  Created by Kiều anh Đào on 5/29/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func presentAlert(withTitle title: String, message : String, completion: @escaping (_ action: Bool) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            completion(true)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) {action in
            completion(false)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showToast(message : String, seconds: Double = 2.0) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func startUsingApp() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let window = appDelegate.window {
                UIView.transition(with: window,
                                  duration: 0.6,
                                  options: .showHideTransitionViews,
                                  animations: { () -> Void in
                                    window.alpha = 0.5
                },
                                  completion: { (_: Bool) -> Void in
                                    let vc = DummyViewController()
                                    window.rootViewController = vc
                                    UIView.transition(with: window,
                                                      duration: 0.6,
                                                      options: .showHideTransitionViews,
                                                      animations: { () -> Void in
                                                        window.alpha = 1.0
                                    }, completion: nil
                                    )
                }
                )
            }
        }
    }
}
