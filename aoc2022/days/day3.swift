//
//  day3.swift
//  aoc2022
//
//  Created by Ben Liset on 12/5/22.
//

import Foundation

class day3: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day3.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day3.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day3.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day3.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        var prioritySum = 0
        input.forEach{ line in
            let halfWayIndex = line.index(line.startIndex, offsetBy: line.count/2)
            let compartment1 = line[..<halfWayIndex].sorted()
            let compartment2 = line[halfWayIndex...].sorted()
            
            var commonChar = "-".first!
            for char1 in compartment1 {
                for char2 in compartment2 {
                    if char1 == char2 {
                        commonChar = char1
                        break
                    }
                }
            }
            
            prioritySum += getPriority(for: commonChar)
        }
        
        return prioritySum
    }
    
    private func runPart2(_ input: [String]) -> Int {
        var prioritySum = 0
        let groups = input.chunked(into: 3)
        groups.forEach{ group in
            
            let sacks = group.map { line in
                line.map { $0 }
            }
            
            let firstSack = sacks.first ?? []
            let commonElements = sacks.dropFirst().reduce(Set(firstSack)) { (result, list)  in
                result.intersection(list)
            }
            
            let priority = commonElements.reduce(0) { partialResult, commonChar in
                partialResult + getPriority(for: commonChar)
            }
            
            prioritySum += priority
        }
        
        return prioritySum
    }
    
    private func getPriority(for character: Character) -> Int {
        let asciiOffset = 96
        let asciiValue = character.asciiValue!
        // uppercase comes after lowercase
        let priority = Int(character.isUppercase ? asciiValue + 58 : asciiValue) - asciiOffset
        return priority
    }
}
