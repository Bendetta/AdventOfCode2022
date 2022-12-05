//
//  day5.swift
//  aoc2022
//
//  Created by Ben Liset on 12/5/22.
//

import Foundation

class day5: Puzzle {
    func runPart1Sample() -> String {
        return runPart1(Input.day5.sample)
    }
    
    func runPart1Actual() -> String {
        return runPart1(Input.day5.actual)
    }
    
    func runPart2Sample() -> String {
        return runPart2(Input.day5.sample)
    }
    
    func runPart2Actual() -> String {
        return runPart2(Input.day5.actual)
    }
    
    private func runPart1(_ input: [String]) -> String {
        var grid = parseGrid(input[0].components(separatedBy: .newlines))
        let instructions = parseInstructions(input[1].splitLines())
        
        for instruction in instructions {
            for _ in 0..<instruction.count {
                var originStack = grid[instruction.origin-1]
                let crate = originStack.pop()
                var destinationStack = grid[instruction.destination-1]
                destinationStack.push(crate)
                
                grid[instruction.origin-1] = originStack
                grid[instruction.destination-1] = destinationStack
            }
        }
        
        
        let topCrates = grid.map { $0.peek() }.joined()
        return topCrates
    }
    
    private func runPart2(_ input: [String]) -> String {
        var grid = parseGrid(input[0].components(separatedBy: .newlines))
        let instructions = parseInstructions(input[1].splitLines())
        
        for instruction in instructions {
            var originStack = grid[instruction.origin-1]
            var tempStack = Stack()
            for _ in 0..<instruction.count {
                
                let crate = originStack.pop()
                tempStack.push(crate)
                
            }
            var destinationStack = grid[instruction.destination-1]
            for _ in 0..<instruction.count {
                let crate = tempStack.pop()
                destinationStack.push(crate)
            }
            
            grid[instruction.origin-1] = originStack
            grid[instruction.destination-1] = destinationStack
        }
        
        
        let topCrates = grid.map { $0.peek() }.joined()
        return topCrates
    }
    
    private func parseGrid(_ input: [String]) -> [Stack] {
        let stackSize = input.last!.split(separator: " ").count
        var stacks = Array(repeating: Stack(), count: stackSize)
        
        let rows = input.reversed().dropFirst()
        for row in rows {
            for count in 0..<stackSize {
                let crate = getCrate(in: row, at: count).trimmingCharacters(in: .whitespaces)
                guard !crate.isEmpty else { continue }
                
                stacks[count].push(crate)
            }
        }
        return stacks
    }
    
    private func getCrate(in row: String, at position: Int) -> String {
        // [H] [T] [Z] - 4 chars per "crate", element at spot #1
        let index = position * 4 + 1
        guard index <= row.count else { return "" }
        return String(row[row.index(row.startIndex, offsetBy: index)])
    }
    
    private func parseInstructions(_ input: [String]) -> [Instruction] {
        let instructionRegex = /move (\d+) from (\d+) to (\d+)/
        return input.map {
            guard let match = $0.firstMatch(of: instructionRegex) else { fatalError("unable to parse regex") }
            let count = Int(match.output.1)!
            let origin = Int(match.output.2)!
            let destination = Int(match.output.3)!
            return Instruction(count: count, origin: origin, destination: destination)
        }
    }
    
    struct Instruction {
        let count: Int
        let origin: Int
        let destination: Int
    }
    
    struct Stack: CustomStringConvertible {
        private var items: [String] = []
        
        func peek() -> String {
            guard let topElement = items.first else { fatalError("This stack is empty.") }
            return topElement
        }
        
        mutating func pop() -> String {
            return items.removeFirst()
        }
      
        mutating func push(_ element: String) {
            items.insert(element, at: 0)
        }
        
        var description: String {
                let topDivider = "---Stack---\n"
                let bottomDivider = "\n-----------\n"

                let stackElements = items.joined(separator: "\n")

                return topDivider + stackElements + bottomDivider
            }
    }
}
