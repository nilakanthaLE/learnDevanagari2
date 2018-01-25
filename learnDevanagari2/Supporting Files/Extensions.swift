//
//  Extensions.swift
//  learnDevanagari2
//
//  Created by Matthias Pochmann on 22.01.18.
//  Copyright © 2018 Matthias Pochmann. All rights reserved.
//

import Foundation

extension Date{ func isGreaterThanDate(dateToCompare:Date) -> Bool { return self.compare(dateToCompare) == .orderedDescending } }


extension Array {
    // Randomizes the order of an array's elements
    mutating func shuffle() {
        for _ in 0..<count {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
    
    func arrayByAppending(o: Element) -> [Element] { return self + [o] }
    
    public init(count: Int, elementCreator: @autoclosure () -> Element) {
        self = (0 ..< count).map { _ in elementCreator() }
    }
}

extension String{
    func newRemoveLast() -> String{
        var start = self
        start.removeLast()
        return start
    }
}

