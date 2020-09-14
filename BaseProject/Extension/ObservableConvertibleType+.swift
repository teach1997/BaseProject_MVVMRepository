//
//  ObservableConvertibleType+.swift
//  DHBC
//
//  Created by Kiều anh Đào on 9/14/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import RxSwift
import RxCocoa

enum Result<Response> {
    case succeeded(Response)
    case failed(Error)
}

extension ObservableConvertibleType {
    func resultDriver() -> Driver<Result<E>> {
        return self.asObservable()
            .map { Result.succeeded($0) }
            .asDriver { Driver.just(Result.failed($0)) }
    }
    
    func result() -> Observable<Result<E>> {
        return self.asObservable()
            .map { Result.succeeded($0) }
            .catchError { Observable.just(Result.failed($0)) }
            .share(replay: 1, scope: .whileConnected)
    }
}
