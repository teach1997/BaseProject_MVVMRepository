//
//  SharedSequence+.swift
//  DHBC
//
//  Created by Kiều anh Đào on 9/14/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import RxSwift
import RxCocoa

typealias DriverResult<Response> = (response: Driver<Response>, error: Driver<Error>)

extension SharedSequence {
    static func split<Response>(result: Driver<Result<Response>>) -> DriverResult<Response> {
        let responseDriver = result.flatMap { result -> Driver<Response> in
            switch result {
            case .succeeded(let response):
                return Driver.just(response)
            case .failed:
                return Driver.empty()
            }
        }
        let errorDriver = result.flatMap { result -> Driver<Error> in
            switch result {
            case .succeeded:
                return Driver.empty()
            case .failed(let error):
                return Driver.just(error)
            }
        }
        return DriverResult(response: responseDriver, error: errorDriver)
    }
}

