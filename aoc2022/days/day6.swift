//
//  day6.swift
//  aoc2022
//
//  Created by Ben Liset on 12/6/22.
//

import Foundation
import Algorithms

class day6: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day6.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day6.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day6.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day6.actual)
    }
    
    private func runPart1(_ input: String) -> Int {
        return findMarker(in: input, ofSize: 4)
    }
    
    private func runPart2(_ input: String) -> Int {
        return findMarker(in: input, ofSize: 14)
    }
    
    private func findMarker(in input: String, ofSize windowSize: Int) -> Int {
        let windows = input.windows(ofCount: windowSize)
        
        guard let index = (windows.firstIndex { Set($0).count == windowSize })
            else { fatalError("message not found") }
        
        return windows.distance(from: windows.startIndex, to: index) + windowSize
    }
}
