//
//  day10.swift
//  aoc2022
//
//  Created by Ben Liset on 12/12/22.
//

import Foundation

class day10: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day10.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day10.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day10.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day10.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        var x = 1
        var cycle = 0
        var signalStrengthSum = 0
        for line in input {
            cycle += 1
            if cycle % 40 == 20 {
                signalStrengthSum += getSignalStrength(cycle: cycle, register: x)
            }
            let parts = line.components(separatedBy: .whitespaces)
            guard parts[0] != "noop" else { continue }
            
            let input = Int(parts[1])!
            cycle += 1
            if cycle % 40 == 20 {
                signalStrengthSum += getSignalStrength(cycle: cycle, register: x)
            }
            x += input
        }
        return signalStrengthSum
    }
    
    private func runPart2(_ input: [String]) -> Int {
        var cycle = 0
        var spritePosition = 1
        var pixelRow = ""
        for line in input {
            
            cycle += 1
            pixelRow += getPixel(atCycle: cycle, middlePixelPosition: spritePosition)
            if cycle % 40 == 0 {
                print(pixelRow)
                pixelRow = ""
            }
            let parts = line.components(separatedBy: .whitespaces)
            guard parts[0] != "noop" else { continue }
            
            cycle += 1
            pixelRow += getPixel(atCycle: cycle, middlePixelPosition: spritePosition)
            let input = Int(parts[1])!
            
            if cycle % 40 == 0 {
                print(pixelRow)
                pixelRow = ""
            }
            spritePosition += input
        }
        return 0
    }
    
    private func getSignalStrength(cycle: Int, register: Int) -> Int {
        return cycle * register
    }
    
    private func getPixel(atCycle cycle: Int, middlePixelPosition position: Int) -> String {
        let index = (cycle-1) % 40
        if (position-1...position+1).contains(index) {
            return "#"
        }
        return "."
    }
    
}
