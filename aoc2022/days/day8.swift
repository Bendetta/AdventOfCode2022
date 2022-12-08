//
//  day8.swift
//  aoc2022
//
//  Created by Ben Liset on 12/8/22.
//

import Foundation

class day8: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day8.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day8.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day8.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day8.actual)
    }
    
    private func runPart1(_ input: [[Int]]) -> Int {
        var visibleTrees = 0
        for row in 0..<input.count {
            for col in 0..<input[row].count {
                if row == 0 || row == input.count - 1 {
                    visibleTrees += 1
                } else if col == 0 || col == input[row].count - 1 {
                    visibleTrees += 1
                } else {
                    let directions = [(-1, 0), (1,0), (0,-1), (0,1)]
                    if !directions.allSatisfy({ isVisible(input, at: (row,col), from: $0)}) {
                        visibleTrees += 1
                    }
                }
            }
        }
        
        return visibleTrees
    }
    
    private func runPart2(_ input: [[Int]]) -> Int {
        var bestScenicScore = 0
        for row in 1..<input.count-1 {
            for col in 1..<input[row].count-1 {
                let directions = [(-1, 0), (1,0), (0,-1), (0,1)]
                let visibleTrees = directions.map{ countVisibleTrees(input, at: (row,col), from: $0)}
                let scenicScore = visibleTrees.reduce(1, *)
                if scenicScore > bestScenicScore {
                    bestScenicScore = scenicScore
                }
            }
        }
        return bestScenicScore
    }
    
    private func isVisible(_ grid: [[Int]], at position: (Int,Int), from direction: (Int,Int)) -> Bool {
        let currentHeight = grid[position.0][position.1]
        var isVisible = false
        var curX = position.0 + direction.0
        var curY = position.1 + direction.1
        while curX >= 0 && curX < grid.count && curY >= 0 && curY < grid[curX].count {
            if grid[curX][curY] < currentHeight {
                curX += direction.0
                curY += direction.1
            } else {
                isVisible = true
                break
            }
        }
        
        return isVisible
    }
    
    private func countVisibleTrees(_ grid: [[Int]], at position: (Int,Int), from direction: (Int,Int)) -> Int {
        let currentHeight = grid[position.0][position.1]
        var visibleTrees = 0
        var curX = position.0 + direction.0
        var curY = position.1 + direction.1
        while curX >= 0 && curX < grid.count && curY >= 0 && curY < grid[curX].count {
            visibleTrees += 1
            if grid[curX][curY] < currentHeight {
                curX += direction.0
                curY += direction.1
            } else {
                break
            }
        }
        
        return visibleTrees
    }
}
