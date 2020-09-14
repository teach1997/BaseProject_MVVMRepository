//
//  Array+.swift
//  DHBC
//
//  Created by Kiều anh Đào on 9/14/20.
//  Copyright © 2020 Anhdk. All rights reserved.
//

extension Array where Element: Equatable {
    
    mutating func remove(value: Element) {
        self.removeAll(where: { $0 == value })
    }
    
    func subtracting(_ other: [Element]) -> [Element] {
        return self.compactMap { element in
            if (other.filter { $0 == element }).count == 0 {
                return element
            } else {
                return nil
            }
        }
    }
    
    mutating func subtract(_ other: [Element]) {
        self = subtracting(other)
    }
    
    func multipling(_ other: [Element]) -> [Element] {
        return self.compactMap { element in
            if (other.filter { $0 == element }).count > 0 {
                return element
            } else {
                return nil
            }
        }
    }
    
    mutating func multiply(_ other: [Element]) {
        self = multipling(other)
    }
    
    mutating func arraySwapIndex(left: Int, right: Int) {
        self.swapAt(left, right)
    }

    mutating func stepSort(left: Int, right: Int) {
        let delta = abs(right - left)
        let sign = (right - left >= 0) ? 1 : -1
        var nextIdx = left + sign
        
        for i in 0..<delta {
            let leftIdx = left + i * sign
            let rightIdx = nextIdx
            arraySwapIndex(left: leftIdx, right: rightIdx)
            nextIdx += sign
        }
    }
    
    var unique: [Element] {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
}
