//
//  day4.swift
//  aoc2022
//
//  Created by Ben Liset on 12/5/22.
//

import Foundation

class day4: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day4.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day4.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day4.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day4.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        let ranges = parseInput(input)
        var overlappedSets = 0
        ranges.forEach { pair in
            let range1 = pair.0
            let range2 = pair.1
            
            if (range2.contains(range1.lowerBound) && range2.contains(range1.upperBound)) ||
                (range1.contains(range2.lowerBound) && range1.contains(range2.upperBound)) {
                overlappedSets += 1
            }
        }
        return overlappedSets
    }
    
    private func runPart2(_ input: [String]) -> Int {
        let ranges = parseInput(input)
        var overlappedSets = 0
        ranges.forEach { pair in
            let range1 = pair.0
            let range2 = pair.1
            
            if range2.contains(range1.lowerBound) || range2.contains(range1.upperBound) ||
                range1.contains(range2.lowerBound) || range1.contains(range2.upperBound) {
                overlappedSets += 1
            }
        }
        return overlappedSets
    }
    
    private func parseInput(_ input: [String]) -> [(ClosedRange<Int>, ClosedRange<Int>)] {
        let result = input.map {
            let parts = $0.components(separatedBy: .punctuationCharacters).map { Int($0)! }
            let range1 = parts[0]...parts[1]
            let range2 = parts[2]...parts[3]
            
            return (range1, range2)
        }
        
        return result
    }
}
