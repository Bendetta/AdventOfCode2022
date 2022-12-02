//
//  day1.swift
//  aoc2022
//
//  Created by Ben Liset on 12/2/22.
//

import Foundation

class day1: Puzzle {
    func runPart1Sample() -> Int {
        let input = Input.day1.sample
        return runPart1(input)
    }
    
    func runPart1Actual() -> Int {
        let input = Input.day1.actual
        return runPart1(input)
    }
    
    func runPart2Sample() -> Int {
        let input = Input.day1.sample
        return runPart2(input)
    }
    
    func runPart2Actual() -> Int {
        let input = Input.day1.actual
        return runPart2(input)
    }
    
    private func runPart1(_ input: [[Int]]) -> Int {
        var elves = [Int]()
        input.forEach { elf in
            elves.append(elf.reduce(0, { $0 + $1 }))
        }
        
        let largest = elves.max() ?? 0
        return largest
    }
    
    private func runPart2(_ input: [[Int]]) -> Int {
        var elves = [Int]()
        input.forEach { elf in
            elves.append(elf.reduce(0, { $0 + $1 }))
        }
        
        let most = elves.sorted().reversed()[0..<3]
        return most.reduce(0, { $0 + $1})
    }
}
