//
//  day14.swift
//  aoc2022
//
//  Created by Ben Liset on 12/14/22.
//

import Foundation
import Algorithms

class day14:  Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day14.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day14.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day14.sample)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day14.actual)
    }
 
    private func runPart1(_ input: [String]) -> Int {
        let cave = mapCave(input)
        var count = 0
        while cave.addSand(hasFloor: false) {
            count += 1
        }
        return count
    }
    
    private func runPart2(_ input: [String]) -> Int {
        let cave = mapCave(input, hasFloor: true)
        
        var count = 1
        while cave.addSand(hasFloor: true) {
            count += 1
        }
        
        return count
    }
    
    enum Particle: String {
        case air = "."
        case rock = "#"
        case sand = "o"
        case start = "+"
    }
    
    private func mapCave(_ input: [String], hasFloor: Bool = false) -> Cave {
        var maxY = 0
        var rocks = [Point: Particle]()
        for line in input {
            let points = line.components(separatedBy: "->").map {
                let coords = $0.trimmingCharacters(in: .whitespaces).components(separatedBy: ",")
                return Point(x: Int(coords[0])!, y: Int(coords[1])!)
            }
            
            for pair in points.adjacentPairs() {
                let p1 = pair.0
                let p2 = pair.1
                let dirX = p1.x - p2.x
                let dirY = p1.y - p2.y
                
                if dirX != 0 {
                    let y = p1.y
                    for x in min(p1.x,p2.x)...max(p1.x,p2.x) {
                        rocks[Point(x: x, y: y)] = .rock
                        if y > maxY { maxY = y }
                    }
                }
                if dirY != 0 {
                    let x = p1.x
                    for y in min(p1.y,p2.y)...max(p1.y,p2.y) {
                        rocks[Point(x: x, y: y)] = .rock
                        if y > maxY { maxY = y }
                    }
                }
            }
        }
        
        rocks[Point(x: 500, y: 0)] = .start
        if hasFloor { maxY += 2 }
        let cave = Cave(particles: rocks, yBounds: 0...maxY)
        return cave
    }
    
    struct Point: Hashable {
        let x: Int
        let y: Int
        
        static let zero = Point(x: 0, y: 0)
        
        init(x: Int, y: Int) {
            self.x = x
            self.y = y
        }
        
        init(_ pair: (Int,Int)) {
            self.init(x: pair.0, y: pair.1)
        }
    }
    
    class Cave {
        private(set) var particles: [Point: Particle]
        let yBounds: ClosedRange<Int>
        let sandStart = Point(x: 500, y: 0)
        
        init(particles: [Point: Particle], yBounds: ClosedRange<Int>) {
            self.particles = particles
            self.yBounds = yBounds
        }
        
        func addSand(hasFloor: Bool) -> Bool {
            var nextPosition = self.sandStart
            
            var canContinue = true
            
            while (canContinue) {
                guard yBounds.contains(nextPosition.y) else { return false }
                
                // ensure rock at the bottom for testing
                if hasFloor {
                    particles[Point(x: nextPosition.x-1, y: self.yBounds.upperBound)] = .rock
                    particles[Point(x: nextPosition.x, y: self.yBounds.upperBound)] = .rock
                    particles[Point(x: nextPosition.x+1, y: self.yBounds.upperBound)] = .rock
                }
                
                if particles[Point(x: nextPosition.x, y: nextPosition.y+1), default: .air] == .air {
                    nextPosition = Point(x: nextPosition.x, y: nextPosition.y + 1)
                } else if particles[Point(x: nextPosition.x-1, y: nextPosition.y+1), default: .air] == .air {
                    nextPosition = Point(x: nextPosition.x-1, y: nextPosition.y+1)
                } else if particles[Point(x: nextPosition.x+1, y: nextPosition.y+1), default: .air] == .air {
                    nextPosition = Point(x: nextPosition.x+1, y: nextPosition.y+1)
                } else {
                    canContinue = false
                }
            }
            
            self.particles[nextPosition] = .sand
            
            return nextPosition != self.sandStart
        }
        
        func draw() {
            let xRange = particles.keys.minAndMax(by: { $0.x < $1.x})!
            let minX = xRange.min.x
            let maxX = xRange.max.x
            for y in self.yBounds {
                var str = ""
                for x in minX-1...maxX+1 {
                    let point = Point(x: x, y: y)
                    str += self.particles[point, default: .air].rawValue
                }
                print(str)
            }
        }
    }
}
