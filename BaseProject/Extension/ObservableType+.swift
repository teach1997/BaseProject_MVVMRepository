//
//  ObservableType+.swift
//  DHBC
//
//  Created by Kiều anh Đào on 9/14/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import RxSwift

typealias ObservableResult<Response> = (response: Observable<Response>, error: Observable<Error>)

extension ObservableType {
    static func split<Response>(result: Observable<Result<Response>>) -> (response: Observable<Response>, error: Observable<Error>) {
        let responseObservable = result.flatMap { result -> Observable<Response> in
            switch result {
            case .succeeded(let response):
                return Observable.just(response)
            case .failed:
                return Observable.empty()
            }
        }
        let errorObservable = result.flatMap { result -> Observable<Error> in
            switch result {
            case .succeeded:
                return Observable.empty()
            case .failed(let error):
                return Observable.just(error)
            }
        }
        return ObservableResult<Response>(response: responseObservable, error: errorObservable)
    }
}
