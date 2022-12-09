//
//  day9.swift
//  aoc2022
//
//  Created by Ben Liset on 12/9/22.
//

import Foundation

class day9: Puzzle {
    func runPart1Sample() -> Int {
        return runPart1(Input.day9.sample)
    }
    
    func runPart1Actual() -> Int {
        return runPart1(Input.day9.actual)
    }
    
    func runPart2Sample() -> Int {
        return runPart2(Input.day9.sampleP2)
    }
    
    func runPart2Actual() -> Int {
        return runPart2(Input.day9.actual)
    }
    
    private func runPart1(_ input: [String]) -> Int {
        let directions = parseInput(input)
        var head = ropeKnot()
        var tail = ropeKnot()
        
        for (direction, distance) in directions {
            for _ in 0..<distance {
                switch direction {
                case .down:
                    head.y -= 1
                case .up:
                    head.y += 1
                case .left:
                    head.x -= 1
                case .right:
                    head.x += 1
                }
                head.history.insert([head.x, head.y])
                
                moveFollower(leader: head, follower: &tail)
            }
        }
        return tail.history.count
    }
    
    private func runPart2(_ input: [String]) -> Int {
        let directions = parseInput(input)
        var head = ropeKnot()
        var knots = Array(repeating: ropeKnot(), count: 9)
        
        for (direction, distance) in directions {
            for _ in 0..<distance {
                switch direction {
                case .down:
                    head.y -= 1
                case .up:
                    head.y += 1
                case .left:
                    head.x -= 1
                case .right:
                    head.x += 1
                }
                head.history.insert([head.x, head.y])
                
                moveFollower(leader: head, follower: &knots[0])
                for i in 1..<9{
                    moveFollower(leader: knots[i-1], follower: &knots[i])
                }
            }
        }
            return knots.last!.history.count
    }
    
    struct ropeKnot{
        var x: Int = 0
        var y: Int = 0
        var history: Set<Array<Int>> = [[0,0]]
    }
    
    func moveFollower(leader: ropeKnot, follower: inout ropeKnot){
        let xdiff = leader.x - follower.x
        let ydiff = leader.y - follower.y
        let axdiff = abs(xdiff)
        let aydiff = abs(ydiff)

        if axdiff <= 1 && aydiff <= 1{
            // touching diagonally
            return
        }
        else if axdiff * aydiff > 1{
            // diagonal move needed
            follower.x += (xdiff / axdiff)
            follower.y += (ydiff / aydiff)
            follower.history.insert([follower.x, follower.y])
            return
        }
        else if axdiff > 0{
            follower.x += (xdiff / axdiff)
            follower.history.insert([follower.x, follower.y])
            return
        }
        else{
            follower.y += (ydiff / aydiff)
            follower.history.insert([follower.x, follower.y])
            return
        }
    }
    
    enum Direction { case left, right, up, down}
    
    private func parseInput(_ input: [String]) -> [(Direction,Int)] {
        return input.map{
            let parts = $0.components(separatedBy: .whitespaces)
            let distance = Int(parts[1])!
            switch parts[0] {
            case "R": return (.right, distance)
            case "U": return (.up, distance)
            case "L": return (.left, distance)
            case "D": return (.down, distance)
            default: fatalError("Unrecognized direction")
            }
        }
    }
}
