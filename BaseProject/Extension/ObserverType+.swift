//
//  ObserverType+.swift
//  DHBC
//
//  Created by Kiều anh Đào on 9/14/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import RxSwift

extension ObserverType where E == Void {
    public func onNext() {
        onNext(())
    }
}
