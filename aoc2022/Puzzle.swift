//
//  Puzzle.swift
//  aoc2021
//
//  Created by Ben Liset on 12/6/21.
//

import Foundation

protocol Puzzle<T> {
    associatedtype T
    func runPart1Sample() -> T
    func runPart1Actual() -> T
    func runPart2Sample() -> T
    func runPart2Actual() -> T
}
