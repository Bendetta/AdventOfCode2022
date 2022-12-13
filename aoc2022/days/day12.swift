//
//  day12.swift
//  aoc2022
//
//  Created by Ben Liset on 12/12/22.
//

import Foundation

class day12: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day12.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day12.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day12.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day12.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        let grid = parseInput(input)
        
        return findExit(grid: grid)
    }
    
    private func runPart2(_ input: [String]) -> Int {
        let grid = parseInput(input)
        return findLowest(grid: grid)
    }
    
    private func parseInput(_ input: [String]) -> Grid {
        let asciiOffset = 97
        let grid = Grid()
        grid.squares.removeFirst()
        for (rowIndex,line) in input.enumerated() {
            var row = [Int]()
            for (colIndex, char) in line.enumerated() {
                if String(char) == "S" {
                    grid.startingPosition = (colIndex, rowIndex)
                    row.append(0) // 'a'
                } else if String(char) == "E" {
                    grid.exit = (colIndex, rowIndex)
                    row.append(25) // 'z'
                } else {
                    row.append(Int(char.asciiValue!) - asciiOffset)
                }
            }
            grid.squares.append(row)
        }
        return grid
    }
    
    private func findExit(grid: Grid) -> Int {
        var queue = Queue<Point>()
        var visitedSquares = Set<String>()
        queue.enqueue(grid.startingPosition)
        visitedSquares.insert("\(grid.startingPosition.0),\(grid.startingPosition.1)")
        var steps: [String: Int] = [:]
        while let node = queue.dequeue() {
            let nodeString = "\(node.0),\(node.1)"
            guard node != grid.exit else {
                return steps[nodeString, default: 0]
            }
            
            let neighbors = grid.neighbors(for: node)
            for neighbor in neighbors {
                let visitedString = "\(neighbor.0),\(neighbor.1)"
                guard !visitedSquares.contains(visitedString) else {
                    continue
                }
                visitedSquares.insert(visitedString)
                steps[visitedString] = steps[nodeString, default: 0] + 1
                queue.enqueue(neighbor)
            }
        }
        return 0
    }
    
    private func findLowest(grid: Grid) -> Int {
        var queue = Queue<Point>()
        var visitedSquares = Set<String>()
        queue.enqueue(grid.exit)
        visitedSquares.insert("\(grid.exit.0),\(grid.exit.1)")
        var steps: [String: Int] = [:]
        var lastNode: Point?
        while let node = queue.dequeue() {
            let nodeString = "\(node.0),\(node.1)"
            guard grid.squares[node.1][node.0] > 0 else {
                return steps[nodeString, default: 0]
            }
            
            let neighbors = grid.neighbors(for: node, findHigher: false)
            for neighbor in neighbors {
                let visitedString = "\(neighbor.0),\(neighbor.1)"
                guard !visitedSquares.contains(visitedString) else {
                    lastNode = neighbor
                    continue
                }
                visitedSquares.insert(visitedString)
                steps[visitedString] = steps[nodeString, default: 0] + 1
                queue.enqueue(neighbor)
            }
        }
        return 0
    }
    
    class Grid {
        var startingPosition: Point = (0,0)
        var exit: Point = (0,0)
        var squares: [[Int]] = [[]]
        
        func neighbors(for pos: Point, findHigher: Bool = true) -> [Point] {
            let height = squares[pos.1][pos.0]
            let neighbors = [
                getSquare(x: pos.0-1, y: pos.1),
                getSquare(x: pos.0+1, y: pos.1),
                getSquare(x: pos.0, y: pos.1-1),
                getSquare(x: pos.0, y: pos.1+1),
            ]
            
            return neighbors.filter({ pos in
                guard let pos = pos else { return false }
                let neighbor = squares[pos.1][pos.0]
                if findHigher {
                    return neighbor <= height + 1
                }
                return neighbor - height >= -1
            })
                .compactMap({ $0 })
        }
        
        private func getSquare(x: Int, y: Int) -> (Point)? {
            if x >= 0 && y >= 0 && y < squares.count && x < squares[y].count {
                return (x,y)
            }
            return nil
        }
    }
    
    struct Queue<T> {
        private var queue: [T] = []
        
        mutating func enqueue(_ element: T) {
            queue.append(element)
        }
        
        mutating func dequeue() -> T? {
            return queue.isEmpty ? nil : queue.removeFirst()
        }
    }
    
    typealias Point = (Int,Int)
}
