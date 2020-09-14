//
//  CheckNetwork.swift
//  DHBC
//
//  Created by Kiều anh Đào on 7/4/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
