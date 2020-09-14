//
//  UITableView+.swift
//  DHBC
//
//  Created by Kiều anh Đào on 9/14/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with cellType: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    
    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.0, animations: {
            self.reloadData()
        }, completion: { finished in
            if finished {
                completion()
            }
        })
    }
}
