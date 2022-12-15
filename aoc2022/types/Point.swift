//
//  Point.swift
//  aoc2022
//
//  Created by Ben Liset on 12/15/22.
//

import Foundation

struct Point: Hashable {
    let x: Int
    let y: Int
    
    static let zero = Point(x: 0, y: 0)
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    init(_ pair: (Int,Int)) {
        self.init(x: pair.0, y: pair.1)
    }
}
