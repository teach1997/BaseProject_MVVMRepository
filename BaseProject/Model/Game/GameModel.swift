//
//  GameModel.swift
//  DHBC
//
//  Created by Kiều anh Đào on 7/3/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseDatabase

protocol IGameModel {
    func fetchQuestionAndAnser() -> Single<GameResponse>
}

class GameModel: IGameModel {
    var disposeBag: DisposeBag
    var ref: DatabaseReference!
    
    init(disposeBag: DisposeBag!) {
        self.disposeBag = disposeBag
    }
    
    func fetchQuestionAndAnser() -> Single<GameResponse> {
        return Single.create { [weak self] single in
            if Connectivity.isConnectedToInternet() {
            self!.ref = Database.database().reference()
                self!.ref.child("dhbc2019").child("questions").child("\(UserDefaults.standard.integer(forKey: "level"))").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let gameResponse = GameResponse(answer: value?["answer"] as? String ?? "", answered: value?["answered"] as? Int ?? 0, dapan: value?["dapan"] as? String ?? "", image: value?["image"] as? String ?? "", online: value?["online"] as? String ?? "", showAds: value?["showAds"] as? String ?? "", suggestWord: value?["suggestWord"] as? String ?? "")
                single(.success(gameResponse))
            }) { (error) in
                single(.error(error))
                }} else {
                    print("error network")
            }
            return Disposables.create()
        }
    }
}
