//
//  RealmList+.swift
//  DHBC
//
//  Created by Kiều anh Đào on 9/14/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import Foundation
import RealmSwift

extension List {
    static func create(array: [Element]) -> List {
        return array.reduce(List<Element>(), { $0.append($1); return $0 })
    }
}
