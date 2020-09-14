//
//  GameViewModel.swift
//  DHBC
//
//  Created by Kiều anh Đào on 7/3/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

import RxSwift
import UIKit

protocol GameViewModelInputs {
    func fetchQestionBody()
    func numberCellInSection(_ section: Int) -> Int
    func chooseAnswer(_ indexPath: IndexPath, _ char: String)
    func removeCharAnswer(_ indexPath: IndexPath, _ uiCollectionView: inout UICollectionView, _ char: String)
    func checkWin() -> Bool
    func showAllCell(_ uiCollectionView: inout UICollectionView)
}

protocol GameViewModelOutputs {
    var responseQuestionBody: Single<GameResponse> { get }
    var questionBody: GameResponse? { get }
    var heightOfAnswer: CGFloat? { get }
    var numberSection: Int? { get }
    var numberCharsInSection: [String]? { get }
    var alphabetCell: [String] { get }
    var answerChar: Dictionary<IndexPath, String> { get }
    var listChooseAnswer: [IndexPath] { get }
    var listAnswerInSection: [[String]] { get }
    func checkMaxChoose() -> Bool
}

protocol GameViewModelType {
    var input: GameViewModelInputs { get }
    var output: GameViewModelOutputs { get }
}

class GameViewModel: GameViewModelType, GameViewModelInputs, GameViewModelOutputs {
    
    var input: GameViewModelInputs { return self }
    var output: GameViewModelOutputs { return self }
    
    var model: IGameModel
    
    init(model: IGameModel!) {
        self.model = model
    }
    
    private func customHeight(_ answer: String) -> CGFloat {
        let words = answer.split(separator: " ")
        switch words.count {
        case 1:
            return 35.0
        case 2:
            return 70.0
        case 3:
            return 105.0
        default:
            return 140.0
        }
    }
    
    private func listCharAnswer(_ answer: String) -> [String] {
        var list: [String] = []
        for char in answer {
            var count = answer.count
            if (list.count + count) < 18 {
                for i in 0...Int.random(in: 0...1) {
                    list.append(Define.latin[Int.random(in: 0..<Define.latin.count)])
                }
            }
            count -= 1
            list.append(String(char))
        }
        return list
    }
    
    private func appendListAnswerInSection(_ answer: String, _ dapan: String) -> [[String]] {
        var listString: [[String]] = []
        for word in dapan.split(separator: " ") {
            var flatText: [String] = []
            let count = listString.count == 0 ? 0 : listString[listString.count - 1].count
            for char in word {
                flatText.append("*")
            }
            listString.append(flatText)
        }
        return listString
    }
    
    //MARK:- GameViewModelInputs
    
    func chooseAnswer(_ indexPath: IndexPath, _ char: String) {
        var section = 0
        outerLoop: for word in listAnswerInSection {
            for i in 0..<word.count {
                if word[i] == "*" {
                    self.listAnswerInSection[section][i] = char
                    break outerLoop
                }
            }
            section += 1
        }
        answerChar.updateValue(char, forKey: indexPath)
        listChooseAnswer.append(indexPath)
    }
    
    func fetchQestionBody() {
        model.fetchQuestionAndAnser().subscribe { (response) in
            switch response {
                
            case .success(let value):
                self.questionBody = value
                self.heightOfAnswer = self.customHeight(value.dapan)
                self.numberSection = value.dapan.split(separator: " ").count
                self.alphabetCell = self.listCharAnswer(value.answer)
                self.listAnswerInSection = self.appendListAnswerInSection(value.answer, value.dapan)
            case .error(_):
                print("error")
            }
        }
    }
    
    func numberCellInSection(_ section: Int) -> Int {
        return questionBody?.dapan.split(separator: " ")[section].count ?? 0
    }
    
    func removeCharAnswer(_ indexPath: IndexPath, _ uiCollectionView: inout UICollectionView, _ char: String) {
        listAnswerInSection[indexPath.section][indexPath.item] = "*"
        for item in 0..<uiCollectionView.numberOfItems(inSection: 0) {
            let index = IndexPath(row:item, section:0)
            let cell = uiCollectionView.cellForItem(at: index) as! CharCell
            print("abc", cell.charLabel!.text! + char)
            if cell.isHidden == true && cell.charLabel!.text! == char {
                cell.isHidden = false
                return
            }
        }
    }
    
    func checkWin() -> Bool {
        var answer: String = ""
        for word in listAnswerInSection {
            for char in word {
                answer += char
            }
        }
        if answer == questionBody?.answer {
            self.listAnswerInSection = [[]]
            return true
        } else {
            return false
        }
    }
    
    func showAllCell(_ uiCollectionView: inout UICollectionView) {
        for item in 0..<uiCollectionView.numberOfItems(inSection: 0) {
            let index = IndexPath(row:item, section:0)
            let cell = uiCollectionView.cellForItem(at: index) as! CharCell
            if cell.isHidden == true {
                cell.isHidden = false
            }
        }
    }
    
    //MARK: - GameViewModelOutputs
    var listAnswerInSection: [[String]] = []
    var alphabetCell: [String] = []
    var numberSection: Int?
    var questionBody: GameResponse?
    var responseQuestionBody: Single<GameResponse> {
        return model.fetchQuestionAndAnser()
    }
    var heightOfAnswer: CGFloat?
    var numberCharsInSection: [String]?
    var answerChar: [IndexPath: String] = [:]
    var listChooseAnswer: [IndexPath] = []
    
    func checkMaxChoose() -> Bool {
        var flat = true
        for word in listAnswerInSection {
            for char in word {
                if char == "*" {
                    return true
                } else {
                    flat = false
                }
            }
        }
        return flat
    }
    
}
