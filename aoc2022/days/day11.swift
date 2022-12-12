//
//  day11.swift
//  aoc2022
//
//  Created by Ben Liset on 12/12/22.
//

import Foundation

class day11: Puzzle {
    let sampleInput = [
        Monkey(items: [79,98], operation: { $0 * 19}, test: (23,2,3)),
        Monkey(items: [54,65,75,74], operation: { $0 + 6}, test: (19,2,0)),
        Monkey(items: [79,60,97], operation: { $0 * $0}, test: (13,1,3)),
        Monkey(items: [74], operation: {$0 + 3}, test: (17,0,1))
    ]
    
    let actualInput = [
        Monkey(items: [57,58], operation: {$0 * 19}, test: (7,2,3)),
        Monkey(items: [66,52,59,79,94,73], operation: {$0 + 1}, test: (19,4,6)),
        Monkey(items: [80], operation: {$0 + 6}, test: (5,7,5)),
        Monkey(items: [82,81,68,66,71,83,75,97], operation: {$0 + 5}, test: (11,5,2)),
        Monkey(items: [55,52,67,70,69,94,90], operation: {$0 * $0}, test: (17,0,3)),
        Monkey(items: [69,85,89,91], operation: {$0 + 7}, test: (13,1,7)),
        Monkey(items: [75,53,73,52,75], operation: {$0 * 7}, test: (2,0,4)),
        Monkey(items: [94,60,79], operation: {$0 + 2}, test: (3,1,6)),
    ]
    func runPart1Sample() -> Int {
        
        return runPart1(sampleInput)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(actualInput)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(sampleInput)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(actualInput)
    }
    
    private func runPart1(_ monkeys: [Monkey]) -> Int {
        let modulus = monkeys.map { $0.test.0 }.reduce(1, { $0 * $1})
        for _ in 0..<20 {
            for monkey in monkeys {
                let newAssignments = monkey.inspectItems(modulus: modulus)
                newAssignments.keys.forEach { key in
                    monkeys[key].items.append(contentsOf: newAssignments[key, default: []])
                }
            }
        }
        return monkeys.map { $0.inspectedItems }.max(count: 2).reduce(1, { $0 * $1})
    }
    
    
    private func runPart2(_ monkeys: [Monkey]) -> Int {
        let modulus = monkeys.map { $0.test.0 }.reduce(1, { $0 * $1})
        for _ in 0..<10000 {
            for monkey in monkeys {
                let newAssignments = monkey.inspectItems(worryDecrease: 1, modulus: modulus)
                newAssignments.keys.forEach { key in
                    monkeys[key].items.append(contentsOf: newAssignments[key, default: []])
                }
            }
        }
        return monkeys.map { $0.inspectedItems }.max(count: 2).reduce(1, { $0 * $1})
    }
    
    class Monkey {
        var items: [Int]
        let operation: (Int) -> Int
        let test: (Int,Int,Int)
        private (set) var inspectedItems: Int = 0
        
        init(items: [Int], operation: @escaping (Int) -> Int, test: (Int, Int, Int)) {
            self.items = items
            self.operation = operation
            self.test = test
        }
        
        func inspectItems(worryDecrease: Int = 3, modulus: Int = 1) -> [Int: [Int]] {
            let updatedItems = items.map { self.operation($0)/worryDecrease % modulus }
            
            var newItemAssignments = [Int: [Int]]()
            for item in updatedItems {
                let newMonkey = item % test.0 == 0 ? test.1 : test.2
                newItemAssignments[newMonkey, default: []].append(item)
                self.inspectedItems += 1
            }
            self.items = []
            return newItemAssignments
        }
    }
}
